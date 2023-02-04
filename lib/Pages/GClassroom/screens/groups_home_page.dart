// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/Pages/GClassroom/Methods/classwork_School.dart';
import 'package:my_project/Pages/GClassroom/screens/assign_grp.dart';
import 'package:my_project/Pages/GClassroom/screens/home_page.dart';
import 'package:my_project/Pages/GClassroom/screens/select_a_school.dart';
import '../../../Creates/add_group.dart';
import '../../../Creates/join_school.dart';
import '../data/classrooms.dart';
//import 'class_room_page.dart';

class GroupHomePage extends StatefulWidget {
  @override
  _GroupHomePageState createState() => _GroupHomePageState();
}

class _GroupHomePageState extends State<GroupHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        //leading: Icon(Icons.menu, color: Colors.black87),
        title: Text(
          "Classroom",
          style: TextStyle(color: Color(0XFF343E87), fontSize: 20),
        ),
        backgroundColor: Color(0xFFD4E7FE),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Color(0XFF343E87),
              size: 24,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text('Create'),
                      children: [
                        SimpleDialogOption(
                          padding: EdgeInsets.all(20),
                          child: const Text("Create a Group"),
                          onPressed: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => AddGroup(),
                              ),
                            );
                          },
                        ),
                        SimpleDialogOption(
                          padding: EdgeInsets.all(20),
                          child: const Text("Create a Class"),
                          onPressed: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SelectSchool(),
                              ),
                            );
                          },
                        ),
                        SimpleDialogOption(
                          padding: EdgeInsets.all(20),
                          child: const Text("Join a Group"),
                          onPressed: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => JoinSchool(),
                              ),
                            );
                          },
                        ),
                        SimpleDialogOption(
                          padding: EdgeInsets.all(20),
                          child: const Text("Create a stream"),
                          onPressed: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    AssignSchool(),
                              ),
                            );
                          },
                        ),
                        SimpleDialogOption(
                          padding: EdgeInsets.all(20),
                          child: const Text("Create a Assignment"),
                          onPressed: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ClassworkSchool(),
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
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid.toString())
            .collection('groups')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, int index) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ClassHomePage(
                        uiColor: classRoomList[index].uiColor,
                        className: snapshot.data!.docs[index].get('className'),
                        bannerImg: classRoomList[index].bannerImg,
                        groupName: snapshot.data!.docs[index].get('uid')),
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: 140,
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.orange,
                      ),
                      child: Image(
                        image: classRoomList[index].bannerImg,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 30),
                      width: 220,
                      child: Text(
                        snapshot.data!.docs[index].get('className'),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 58, left: 30),
                      child: Text(
                        snapshot.data!.docs[index].get('description'),
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            letterSpacing: 1),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 125, left: 30),
                      child: Text(
                        snapshot.data!.docs[index].get('creatorid'),
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white54,
                            letterSpacing: 1),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 370),
                      child: IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        splashColor: Colors.white54,
                        onPressed: () {},
                        iconSize: 25,
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
