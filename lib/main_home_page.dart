// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'Pages/GClassroom/screens/groups_home_page.dart';
import 'Pages/Profile/edit_profile.dart';
import 'Pages/Social/add_post_screen.dart';
import 'Pages/Social/choose_yearbook.dart';
import 'home.dart';

void main() {
  runApp(SchoolManagement());
}

class SchoolManagement extends StatefulWidget {
  @override
  _SchoolManagementState createState() => _SchoolManagementState();
}

class _SchoolManagementState extends State<SchoolManagement> {
  int _selectedItemIndex = 0;
  final List pages = [
    HomePage(),
    ChooseYearbook(),
    //FeedScreen(),
    // AddPostScreen(),
    //UploadPost(),
    GroupHomePage(),
    SettingsUI(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Color(0xFFD4E7FE),
            unselectedItemColor: Colors.grey,
            selectedItemColor: Color(0XFF343E87),
            //selectedIconTheme: IconThemeData(color: Colors.blueGrey[600]),
            currentIndex: _selectedItemIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (int index) {
              setState(() {
                _selectedItemIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                label: "",
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: "",
                icon: Icon(Icons.auto_awesome),
              ),
              // BottomNavigationBarItem(
              //   label: "",
              //   icon: Icon(Icons.add),
              // ),
              BottomNavigationBarItem(
                label: "",
                icon: Icon(Icons.school),
              ),
              // BottomNavigationBarItem(
              //   label: "",
              //   icon: Icon(Icons.calendar_today),
              // ),
              BottomNavigationBarItem(
                label: "",
                icon: Icon(Icons.account_box),
              ),
            ],
          ),
          body: pages[_selectedItemIndex]),
    );
  }
}
