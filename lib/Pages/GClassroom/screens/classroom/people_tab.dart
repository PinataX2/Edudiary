// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../data/classrooms.dart';
import '../../data/comments.dart';
import '../../widgets/profile_tile.dart';

class PeopleTab extends StatefulWidget {
  String classId;

  PeopleTab({required this.classId});
  @override
  _PeopleTabState createState() => _PeopleTabState();
}

class _PeopleTabState extends State<PeopleTab> {
  String groupId = "something";

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  void getUserName() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('class')
        .doc(widget.classId)
        .get();

    setState(() {
      groupId = (snap.data() as Map<String, dynamic>)['groupid'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   padding: EdgeInsets.only(top: 30, left: 15, bottom: 10),
        //   child: Text(
        //     "Admin",
        //     style: TextStyle(
        //         fontSize: 30, color: Color(0XFF343E87), letterSpacing: 1),
        //   ),
        // ),
        // Container(
        //   margin: EdgeInsets.only(left: 15),
        //   width: MediaQuery.of(context).size.width - 30,
        //   height: 2,
        //   color: Color(0XFF343E87),
        // ),
        // Profile(
        //   name: classRoomList[0].creator, // Teacher name
        // ),
        SizedBox(width: 30),
        Container(
          padding: EdgeInsets.only(top: 30, left: 15, bottom: 10),
          child: Text(
            "Classmates",
            style: TextStyle(
                fontSize: 30, color: Color(0XFF343E87), letterSpacing: 1),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15),
          width: MediaQuery.of(context).size.width - 30,
          height: 2,
          color: Color(0XFF343E87),
        ),
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('groups')
                .doc(groupId)
                .collection('members')
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
                  return Profile(
                    name: snapshot.data!.docs[index].get('member_email'),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
