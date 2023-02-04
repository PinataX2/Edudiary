// ignore_for_file: prefer_const_constructors, empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/Pages/Profile/edit_profile.dart';

class ConfirmChangeSchool extends StatefulWidget {
  String schoolId;
  ConfirmChangeSchool({super.key, required this.schoolId});

  @override
  State<ConfirmChangeSchool> createState() => _ConfirmChangeSchoolState();
}

class _ConfirmChangeSchoolState extends State<ConfirmChangeSchool> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future ConfirmChangeSchool() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String groupName = '';

    try {
      //getting yearbook data
      DocumentSnapshot snap =
          await _firestore.collection('groups').doc(widget.schoolId).get();
      setState(() {
        groupName = (snap.data() as Map<String, dynamic>)['className'];
      });
      //updating data
      _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .update({
        'currentSchool': groupName,
        'currentSchoolId': widget.schoolId,
      });

      showDialog(
          context: context, // code alteration here maybe
          builder: (context) {
            return AlertDialog(
              content: Text('Success'),
            );
          });

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => EditProfilePage()));
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
                  'Confirm The Change!',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 52,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                // Text(
                //   'Add Code',
                //   style: TextStyle(
                //     fontSize: 24,
                //   ),
                // ),

                SizedBox(
                  height: 30,
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
                        enabled: false,
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Confirm The Change?',
                          hintText: 'Confirm The Change?',
                        ),
                      ),
                    ),
                  ),
                ),
                // password
                SizedBox(height: 10),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Color(0xFFD4E7FE),
                //       border: Border.all(color: Colors.white),
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.only(left: 20.0),
                //       child: TextField(
                //         controller: _passwordController,
                //         decoration: InputDecoration(
                //           border: InputBorder.none,
                //           hintText: 'Description',
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(height: 10),
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
                    onTap: ConfirmChangeSchool,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0XFF343E87),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Confirm!',
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      (Navigator.of(context).pop());
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
                SizedBox(height: 25),
                // register button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
