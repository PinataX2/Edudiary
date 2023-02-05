// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'Pages/GClassroom/screens/groups_home_page.dart';
import 'Pages/Profile/edit_profile.dart';
import 'Pages/Social/Methods/choose_yearbook.dart';
import 'home.dart';

// void main() {
//   runApp(SchoolManagement());
// }

class SchoolManagement extends StatefulWidget {
  int index;
  SchoolManagement({super.key, required this.index});
  @override
  _SchoolManagementState createState() => _SchoolManagementState();
}

class _SchoolManagementState extends State<SchoolManagement> {
  final List pages = [
    HomePage(),
    ChooseYearbook(),
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
            currentIndex: widget.index,
            type: BottomNavigationBarType.fixed,
            onTap: (int index) {
              setState(() {
                widget.index = index;
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
              BottomNavigationBarItem(
                label: "",
                icon: Icon(Icons.school),
              ),
              BottomNavigationBarItem(
                label: "",
                icon: Icon(Icons.account_box),
              ),
            ],
          ),
          body: pages[widget.index]),
    );
  }
}
