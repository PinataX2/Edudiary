// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/main_home_page.dart';
import 'auth_page.dart';

class Mainpage extends StatelessWidget {
  const Mainpage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //return HomePage();
            return SchoolManagement();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
