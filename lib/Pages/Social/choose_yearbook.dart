// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/Pages/Social/join_yearbook.dart';

import '../../Creates/create_yearbook.dart';
import 'feed_Screen.dart';

class ChooseYearbook extends StatelessWidget {
  const ChooseYearbook({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // ignore: prefer_const_literals_to_create_immutables
        appBar: AppBar(
          backgroundColor: Color(0xFFD4E7FE),
          title: Text(
            'Yearbooks',
            style: TextStyle(color: Color(0XFF343E87)),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: Text('Create'),
                        children: [
                          SimpleDialogOption(
                            padding: EdgeInsets.all(20),
                            child: const Text("Create a Yearbook"),
                            onPressed: () async {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      CreateYearbook(),
                                ),
                              );
                            },
                          ),
                          SimpleDialogOption(
                            padding: EdgeInsets.all(20),
                            child: const Text("Join a Yearbook"),
                            onPressed: () async {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      JoinYearBook(),
                                ),
                              );
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
              },
              icon: Icon(
                Icons.add,
                color: Color(0XFF343E87),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // hello again!
                // Icon(
                //   Icons.android,
                //   size: 100,
                // ),
                SizedBox(height: 75),
                Text(
                  'Choose a Yearbook!',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 52,
                  ),
                ),

                SizedBox(
                  height: 50,
                ),
                SingleChildScrollView(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('yearbooks')
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ListView.builder(
                        physics: ScrollPhysics(), //important
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25.0,
                              vertical: 10,
                            ),
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => FeedScreen(
                                      yearbookid: snapshot.data!.docs[index]
                                          .get('yearbookId')),
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Color(0XFF343E87),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    snapshot.data!.docs[index]
                                        .get('yearbookName'),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // ignore: prefer_const_literals_to_create_immutables
                  ),
                ),
                SizedBox(height: 10),
                // sign in button

                // register button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
