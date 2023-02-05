// ignore_for_file: prefer_const_constructors, empty_catches

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/Pages/GClassroom/screens/home_page.dart';
import 'package:my_project/main_home_page.dart';
import 'package:uuid/uuid.dart';

import '../../screens/groups_home_page.dart';

class AddGroup extends StatefulWidget {
  const AddGroup({super.key});

  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future addGroup() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String groupId = Uuid().v1();
    try {
      _firestore.collection('groups').doc(groupId).set({
        'className': _emailController.text.trim(),
        'description': _passwordController.text.trim(),
        'uid': groupId,
        'creatorid': FirebaseAuth.instance.currentUser!.uid.toString(),
        'creatoremail': FirebaseAuth.instance.currentUser!.email.toString()
      });
      //adding to user db
      _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .collection('groups')
          .doc(groupId)
          .set({
        'className': _emailController.text.trim(),
        'description': _passwordController.text.trim(),
        'uid': groupId,
        'creatorid': FirebaseAuth.instance.currentUser!.uid.toString(),
        'creatoremail': FirebaseAuth.instance.currentUser!.email.toString(),    
      });
      // adding as a member
      _firestore
          .collection('groups')
          .doc(groupId)
          .collection('members')
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .set({
        'uid': FirebaseAuth.instance.currentUser!.uid.toString(),
        'member_email': FirebaseAuth.instance.currentUser!.email.toString()
      });
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => SchoolManagement(index:2),
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
                  size: 100,
                  color: Color(0XFF343E87),
                ),
                SizedBox(height: 50),
                Text(
                  'Create a Group!',
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
                          hintText: 'Group Name',
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
                    onTap: addGroup,
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
