// ignore_for_file: prefer_const_constructors, empty_catches, no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/main_home_page.dart';
import 'package:uuid/uuid.dart';
import 'choose_yearbook.dart';

class CreateYearbook extends StatefulWidget {
  const CreateYearbook({super.key});

  @override
  State<CreateYearbook> createState() => _CreateYearbookState();
}

class _CreateYearbookState extends State<CreateYearbook> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future CreateYearbook() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String yearbookId = Uuid().v1();

    try {
      //adding yearbook data
      _firestore.collection('Yearbooks').doc(yearbookId).set({
        'creatorid': FirebaseAuth.instance.currentUser!.uid.toString(),
        'creatorName': FirebaseAuth.instance.currentUser!.email.toString(),
        'yearbookId': yearbookId,
        'yearbookName': _emailController.text.trim(),
        'description': _passwordController.text.trim(),
      });
      //adding yearbook to users
      _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .collection('yearbooks')
          .doc(yearbookId)
          .set({
        'creatorid': FirebaseAuth.instance.currentUser!.uid.toString(),
        'creatorName': FirebaseAuth.instance.currentUser!.email.toString(),
        'yearbookId': yearbookId,
        'yearbookName': _emailController.text.trim(),
        'description': _passwordController.text.trim(),
      });

      showDialog(
          context: context, // code alteration here maybe
          builder: (context) {
            return AlertDialog(
              content: Text('Success'),
            );
          });

      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SchoolManagement(index: 1)));
    } catch (e) {
      showDialog(
          context: context, // code alteration here maybe
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
                  'Create a yearbook!',
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
                          hintText: 'Yearbook Name',
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
                    onTap: CreateYearbook,
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
