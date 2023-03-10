// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  String name;

  Profile({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          SizedBox(width: 15),
          CircleAvatar(
            child: Icon(
              Icons.person,
              size: 30,
              color: Colors.grey,
            ),
            backgroundColor: Colors.grey[400],
          ),
          SizedBox(
            width: 10,
          ),
          Text(name)
        ],
      ),
    );
  }
}
