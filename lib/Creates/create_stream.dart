// ignore_for_file: prefer_const_constructors, empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../Pages/GClassroom/screens/groups_home_page.dart';

class CreateStream extends StatefulWidget {
  String classId;
  CreateStream({super.key, required this.classId});
  //const CreateStream({super.key});

  @override
  State<CreateStream> createState() => _CreateStreamState();
}

class _CreateStreamState extends State<CreateStream> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _IdController = TextEditingController();
  Future CreateStream() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String streamId = Uuid().v1();
    try {
      _firestore
          .collection('class')
          .doc(widget.classId)
          .collection('stream')
          .doc(streamId)
          .set(
        {
          'title': _emailController.text.trim(),
          'description': _passwordController.text.trim(),
          'assignId': streamId,
          'classId': widget.classId,
        },
      );
      showDialog(
          context: this.context, // code alteration here maybe
          builder: (context) {
            return AlertDialog(
              content: Text('Success'),
            );
          });
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => GroupHomePage(),
        ),
      );
    } catch (e) {
      showDialog(
          context: this.context, // code alteration here maybe
          builder: (context) {
            return AlertDialog(
              content: Text(e.toString()),
            );
          });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String classId = widget.classId; // taking the school id
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
                Icon(
                  Icons.chrome_reader_mode,
                  color: Color(0XFF343E87),
                  size: 100,
                ),
                SizedBox(height: 50),
                Text(
                  'Create a Stream!',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 52,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Text(
                  'Add Details',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),

                SizedBox(
                  height: 50,
                ),
                // select school

                // School text field
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
                        enabled: false,
                        controller: _IdController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: classId,
                          labelText: 'Class Id : ' + classId, // shcool id here
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                // email text field
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
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Title',
                        ),
                      ),
                    ),
                  ),
                ),
                // password
                SizedBox(height: 10),
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
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Description',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // ignore: prefer_const_literals_to_create_immutables
                  ),
                ),
                SizedBox(height: 10),
                // sign in button
                // ignore: avoid_unnecessary_containers
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                  ),
                  child: GestureDetector(
                    onTap: CreateStream,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0XFF343E87),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Create',
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
                // SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 10,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0XFF343E87),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
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

                // register button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
