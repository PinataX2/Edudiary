// ignore_for_file: prefer_const_constructors, empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/main_home_page.dart';
import 'package:uuid/uuid.dart';
import 'choose_yearbook.dart';

class JoinYearBook extends StatefulWidget {
  const JoinYearBook({super.key});

  @override
  State<JoinYearBook> createState() => _JoinYearBookState();
}

class _JoinYearBookState extends State<JoinYearBook> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future JoinYearBook() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String yearbookId = _emailController.text.trim();
    String creatorId = '';
    String creatorName = '';
    String yearbookName = '';
    String description = '';

    try {
      //getting yearbook data
      DocumentSnapshot snap =
          await _firestore.collection('Yearbooks').doc(yearbookId).get();
      setState(() {
        creatorId = (snap.data() as Map<String, dynamic>)['creatorid'];
        creatorName = (snap.data() as Map<String, dynamic>)['creatorName'];
        yearbookName = (snap.data() as Map<String, dynamic>)['yearbookName'];
        description = (snap.data() as Map<String, dynamic>)['description'];
      });
      //adding yearbook to users
      _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .collection('yearbooks')
          .doc(yearbookId)
          .set({
        'creatorid': creatorId,
        'creatorName': creatorName,
        'yearbookId': yearbookId,
        'yearbookName': yearbookName,
        'description': description,
      });

      showDialog(
          context: context, // code alteration here maybe
          builder: (context) {
            return AlertDialog(
              content: Text('Success'),
            );
          });

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SchoolManagement(index: 1),
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
                  'Join a Yearbook!',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 52,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Text(
                  'Add Code',
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
                          hintText: 'Yearbook Name',
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
                    onTap: JoinYearBook,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0XFF343E87),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Join',
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
