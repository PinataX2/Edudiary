// ignore_for_file: prefer_const_constructors, duplicate_ignore, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/Pages/GClassroom/widgets/profile_tile.dart';
import 'package:my_project/Pages/Profile/edit_profile.dart';

class ChangeProfile extends StatefulWidget {
  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  Future updateProfile() async {
    try {
      // add user details
      updateUserDetails(
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        int.parse(_ageController.text.trim()),
        _phoneController.text.trim(),
        _addressController.text.trim(),
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => EditProfilePage(),
        ),
      );

      // showDialog(
      //     context: this.context, // code alteration here maybe
      //     builder: (context) {
      //       return AlertDialog(
      //         content: Text("Passwords Do not match!"),
      //       );
      //     });

    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: this.context, // code alteration here maybe
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  Future updateUserDetails(
    String firstName,
    String lastName,
    int age,
    String phone,
    String address,
  ) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(
      {
        'first name': firstName,
        'last name': lastName,
        'age': age,
        'phone': phone,
        'address': address,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // ignore: prefer_const_literals_to_create_immutables

      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // hello again!
                // Text(
                //   'Hello There!',
                //   style: GoogleFonts.bebasNeue(
                //     fontSize: 52,
                //   ),
                // ),

                // SizedBox(
                //   height: 10,
                // ),

                Text(
                  'Update the following details',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                // First text field
                // ignore: prefer_const_constructors, avoid_unnecessary_containers
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD4E7FE),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'First Name',
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // lAST text field
                // ignore: prefer_const_constructors, avoid_unnecessary_containers
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD4E7FE),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Last Name',
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                // age text field
                // ignore: prefer_const_constructors, avoid_unnecessary_containers
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD4E7FE),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _ageController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Age',
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                //Address text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD4E7FE),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Address',
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                //Phone Number text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD4E7FE),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Phone Number',
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                //Proffession text field

                // email text field
                // ignore: prefer_const_constructors, avoid_unnecessary_containers

                // password

                // confirm password text field

                // sign in button
                // ignore: avoid_unnecessary_containers
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                  ),
                  child: GestureDetector(
                    onTap: updateProfile,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0XFF343E87),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                // register button
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   // ignore: prefer_const_literals_to_create_immutables
                //   children: [
                //     Text(
                //       'I am a member!',
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: widget.showLoginPage,
                //       child: Text(
                //         ' Login now',
                //         style: TextStyle(
                //           color: Colors.blue,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
