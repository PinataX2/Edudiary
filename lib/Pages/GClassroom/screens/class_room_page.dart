// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'classroom/classwork_tab.dart';
import 'classroom/people_tab.dart';
import 'classroom/stream_tab.dart';

class ClassRoomPage extends StatefulWidget {
  AssetImage bannerImg;
  String className;
  String classId;
  Color uiColor;

  ClassRoomPage(
      {required this.className,
      required this.bannerImg,
      required this.uiColor,
      required this.classId});

  @override
  _ClassRoomPageState createState() => _ClassRoomPageState();
}

class _ClassRoomPageState extends State<ClassRoomPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String className = widget.className;
    AssetImage bannerImg = widget.bannerImg;
    final tabs = [
      StreamTab(
        bannerImg: bannerImg,
        className: className,
        classId: widget.classId,
      ),
      ClassWork(classId: widget.classId),
      PeopleTab(classId: widget.classId)
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD4E7FE),
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0XFF343E87)),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Color(0XFF343E87)),
            onPressed: () {},
          ),
        ],
      ),
      body: tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Stream',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Classwork',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'People',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0XFF343E87),
        backgroundColor: Color(0xFFD4E7FE),
        onTap: _onItemTapped,
      ),
    );
  }
}
