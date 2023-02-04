// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_project/Creates/create_stream.dart';
import 'package:my_project/Pages/GClassroom/Methods/classwork_create.dart';
import '../data/classrooms.dart';
 
//import 'class_room_page.dart';

class ClassworkClass extends StatefulWidget {
  String schoolId;
  ClassworkClass({super.key, required this.schoolId});
  //const AddClass({super.key});
  @override
  _ClassworkClassState createState() => _ClassworkClassState();
}

class _ClassworkClassState extends State<ClassworkClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        //leading: Icon(Icons.menu, color: Colors.black87),
        title: Text(
          "Classroom : Select Class",
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
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('class')
            .where('groupid', isEqualTo: widget.schoolId)
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
                    builder: (_) => CreateClasswork(
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
                        'School Id :' +
                            snapshot.data!.docs[index].get('classid'),
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
