// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../data/classrooms.dart';
import 'class_room_page.dart';

class ClassHomePage extends StatefulWidget {
  AssetImage bannerImg;
  String className;
  Color uiColor;
  String groupName;
  ClassHomePage(
      {super.key,
      required this.className,
      required this.bannerImg,
      required this.uiColor,
      required this.groupName});

  @override
  _ClassHomePageState createState() => _ClassHomePageState();
}

class _ClassHomePageState extends State<ClassHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0XFF343E87)),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
        //leading: Icon(Icons.menu, color: Colors.black87),
        title: Text(
          "Classroom : Your Classes",
          style: TextStyle(color: Color(0XFF343E87), fontSize: 20),
        ),
        backgroundColor: Color(0xFFD4E7FE),
        actions: [
          // IconButton(
          //   icon: Icon(
          //     Icons.add,
          //     color: Color(0XFF343E87),
          //     size: 24,
          //   ),
          //   onPressed: () {},
          // ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('class')
            .where('groupid', isEqualTo: widget.groupName)
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
                    builder: (_) => ClassRoomPage(
                      uiColor: classRoomList[index].uiColor,
                      className: snapshot.data!.docs[index].get('className'),
                      bannerImg: classRoomList[index].bannerImg,
                      classId: snapshot.data!.docs[index].get('classid'),
                    ),
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
                          fontSize: 22,
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
                        'Class ' + (index + 1).toString(),
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
