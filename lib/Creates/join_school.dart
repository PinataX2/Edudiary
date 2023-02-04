// ignore_for_file: prefer_const_constructors, empty_catches
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../Pages/GClassroom/screens/groups_home_page.dart';

class JoinSchool extends StatefulWidget {
  JoinSchool({
    super.key,
  });
  //const JoinSchool({super.key});

  @override
  State<JoinSchool> createState() => _JoinSchoolState();
}

class _JoinSchoolState extends State<JoinSchool> {
  // text controllers
  final _schoolCode = TextEditingController();

  Future JoinSchool() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String classId = Uuid().v1();
    String Schoolcode = _schoolCode.text.trim();
    try {
      //retrieving schooldata
      DocumentSnapshot snap =
          await _firestore.collection('groups').doc(Schoolcode).get();
      String className = (snap.data() as Map<String, dynamic>)["className"];
      String creatorid = (snap.data() as Map<String, dynamic>)["creatorid"];
      String description = (snap.data() as Map<String, dynamic>)["description"];
      //adding to groups db
      _firestore
          .collection('groups')
          .doc(Schoolcode)
          .collection('members')
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .set(
        {
          'member_email': FirebaseAuth.instance.currentUser!.email.toString(),
          'uid': FirebaseAuth.instance.currentUser!.uid.toString(),
        },
      );

      // adding to users db
      _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .collection('groups')
          .doc(Schoolcode)
          .set(
        {
          'className': className,
          'creatorid': creatorid,
          'description': description,
          'uid': Schoolcode,
        },
      );

      showDialog(
          context: context, // code alteration here maybe
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
    _schoolCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // taking the school id
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
                  'Join a Group!',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 52,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Text(
                  'Enter Code',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),

                SizedBox(
                  height: 50,
                ),
                // select school

                // School text field

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
                        controller: _schoolCode,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter School',
                        ),
                      ),
                    ),
                  ),
                ),
                // password

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
                    onTap: JoinSchool,
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
