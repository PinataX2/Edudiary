// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/Methods/storage_methods.dart';
import 'package:my_project/Methods/utils.dart';
import 'package:my_project/Pages/Profile/change_profile.dart';
import 'settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  String username = "";
  String email = "";
  Uint8List? _image;
  String profilUrl = '';
  String job = '';
  String phone = '';
  String lastname = '';
  String fullname = '';
  String address = '';
  @override
  void initState() {
    super.initState();
    getUserName();
  }

  void selectImage() async {
    try {
      Uint8List im = await pickImage(ImageSource.gallery);
      setState(() {
        _image = im;
      });
    } catch (e) {
      print(e);
    }
  }

  void getUserName() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = (snap.data() as Map<String, dynamic>)['first name'];
      lastname = (snap.data() as Map<String, dynamic>)['last name'];
      fullname = username + lastname;
      email = (snap.data() as Map<String, dynamic>)['email'];
      profilUrl = (snap.data() as Map<String, dynamic>)['profilepic'];
      job = (snap.data() as Map<String, dynamic>)['job'];
      phone = (snap.data() as Map<String, dynamic>)['phone'];
      address = (snap.data() as Map<String, dynamic>)['address'];
    });
  }

  Future updateProfileImage() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    if (_image != null) {
      String photoUrl = await StorageMethods()
          .uploadImageToStorage('profilePics', _image!, false);
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        "profilepic": photoUrl,
      });
      showDialog(
          context: context, // code alteration here maybe
          builder: (context) {
            return AlertDialog(
              content: Text("Image Uploaded Succesfully!"),
            );
          });
    } else {
      showDialog(
          context: context, // code alteration here maybe
          builder: (context) {
            return AlertDialog(
              content: Text("Upload Image First!"),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFD4E7FE),
          elevation: 0,
          title: Text(
            'Your Profile',
            style: TextStyle(color: Color(0XFF343E87)),
          ),
          bottomOpacity: 0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Color(0XFF343E87),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => SettingsPage()));
              },
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(left: 16, top: 0, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                // Center(
                //   child: Text(
                //     "Your Profile",
                //     style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                //   ),
                // ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      _image != null
                          ? Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 10))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: MemoryImage(_image!),
                                ),
                              ),
                            )
                          : Container(
                              //ternary operator
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 10))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    profilUrl,
                                  ),
                                ),
                              ),
                            ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: selectImage,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: Color(0XFF343E87),
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                buildTextField("Full Name", "$username", false),
                buildTextField("E-mail", "$email", false),
                buildTextField("Profession", "$job ", true),
                buildTextField("Lives At", "$address", false),
                buildTextField("Phone Number", "$phone", false),
                SizedBox(
                  height: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      color: Color(0XFF343E87),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ChangeProfile()));
                      },
                      child: Text("Edit",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      onPressed:
                          updateProfileImage, //profile image function call
                      color: Color(0XFF343E87),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Post(DP)",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        enabled: false,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            // suffixIcon: isPasswordTextField
            //     /? IconButton(
            //         onPressed: () {
            //           setState(() {
            //             showPassword = !showPassword;
            //           });
            //         },
            //         icon: Icon(
            //           Icons.remove_red_eye,
            //           color: Colors.grey,
            //         ),
            //       )
            //     : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Color(0XFF343E87),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              //fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
