// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/Methods/firestore_methods.dart';
import 'package:my_project/Methods/utils.dart';

class AddPostScreen extends StatefulWidget {
  //const AddPostScreen({super.key});
  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  String username = "";
  String email = "";
  //Uint8List? _image;
  String profilUrl = '';
  String uid = "";
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  void getUserName() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = (snap.data() as Map<String, dynamic>)['first name'];
      email = (snap.data() as Map<String, dynamic>)['email'];
      profilUrl = (snap.data() as Map<String, dynamic>)['profilepic'];
      uid = (snap.data() as Map<String, dynamic>)['uid'];
    });
  }

  void postImage(String uid, String username, String profImage) async {
    try {
      String res = await FireStoreMethods().uploadPost(
          _descriptionController.text.trim(), _file!, uid, username, profImage,'yearbookid');
      showDialog(
          context: context, // code alteration here maybe
          builder: (context) {
            return AlertDialog(
              content: Text("Upload Successful !"),
            );
          });
    } catch (e) {
      print(e);
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Create a post'),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text("Take a photo"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.camera,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text("Choose from gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.gallery,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text("Cancel"),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _file == null
        ? Center(
            child: IconButton(
              icon: const Icon(Icons.upload),
              onPressed: () => _selectImage(context),
            ),
          )
        : SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFFD4E7FE),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color(0XFF263064),
                  ),
                  onPressed: () {},
                ),
                title: const Text(
                  'Post To ',
                  style: TextStyle(color: Color(0XFF263064)),
                ),
                actions: [
                  TextButton(
                    onPressed: () => postImage(uid, email, profilUrl),
                    child: const Text(
                      'Post ',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 35),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(profilUrl),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: TextField(
                              controller: _descriptionController,
                              decoration: InputDecoration(
                                hintText: 'Write Caption',
                                border: InputBorder.none,
                              ),
                              maxLines: 8,
                            ),
                          ),
                          SizedBox(
                            height: 110,
                            width: 110,
                            child: AspectRatio(
                              aspectRatio: 487 / 451,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: MemoryImage(_file!),
                                    fit: BoxFit.fill,
                                    alignment: FractionalOffset.topCenter,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
