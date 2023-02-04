// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../../widgets/comment_composer.dart';

class StreamTab extends StatefulWidget {
  AssetImage bannerImg;
  String className;
  String classId;

  StreamTab(
      {required this.bannerImg,
      required this.className,
      required this.classId});

  @override
  _StreamTabState createState() => _StreamTabState();
}

class _StreamTabState extends State<StreamTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Image(
                  image: widget.bannerImg,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: 200,
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(bottom: 40, left: 30),
                child: Text(
                  widget.className,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            ],
          ),
        ),
        // Container(
        //     margin: EdgeInsets.symmetric(horizontal: 15),
        //     height: 60,
        //     decoration: BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.circular(5),
        //         boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 3)]),
        //     child: Row(
        //       children: [
        //         SizedBox(width: 10),
        //         CircleAvatar(
        //           backgroundImage: AssetImage('assets/images/Dp/cat3.jpg'),
        //         ),
        //         SizedBox(width: 10),
        //         Text(
        //           "Share with your class...",
        //           style: TextStyle(color: Colors.grey),
        //         )
        //       ],
        //     )),
        CommentComposer(classId:widget.classId),
      ],
    );
  }
}
