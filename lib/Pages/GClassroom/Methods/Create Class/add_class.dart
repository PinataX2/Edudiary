// ignore_for_file: prefer_const_constructors, empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/main_home_page.dart';
import 'package:uuid/uuid.dart';

import '../../screens/groups_home_page.dart';

class AddClass extends StatefulWidget {
  String schoolId;
  AddClass({super.key, required this.schoolId});
  //const AddClass({super.key});

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _IdController = TextEditingController();
  Future AddClass() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String classId = Uuid().v1();
    try {
      _firestore.collection('class').doc(classId).set(
        {
          'className': _emailController.text.trim(),
          'description': _passwordController.text.trim(),
          'classid': classId,
          'creatorid': FirebaseAuth.instance.currentUser!.uid.toString(),
          'groupid': widget.schoolId,
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
          builder: (_) => SchoolManagement(index: 2),
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
    String schoolId = widget.schoolId; // taking the school id
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
                  'Create a Class!',
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
                          hintText: schoolId,
                          labelText: 'Group Id : ' + schoolId, // shcool id here
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
                          hintText: 'Class Name',
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
                    onTap: AddClass,
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
