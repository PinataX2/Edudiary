// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, use_key_in_widget_constructors, unnecessary_string_interpolations
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../data/comments.dart';

class CommentComposer extends StatefulWidget {
  String classId;
  CommentComposer({required this.classId});
  @override
  _CommentComposerState createState() => _CommentComposerState();
}

class _CommentComposerState extends State<CommentComposer> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('class')
            .doc(widget.classId)
            .collection('stream')
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
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 0)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 10),
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage("${commentList[index].userDp}"),
                            ),
                            SizedBox(width: 10),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data!.docs[index].get('title'),
                                    style: TextStyle(),
                                  ),
                                  Text(
                                    snapshot.data!.docs[index].get('title'),
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ]),
                          ],
                        ),
                        // IconButton(
                        //   icon: Icon(
                        //     Icons.more_vert,
                        //     color: Colors.grey,
                        //   ),
                        //   onPressed: () {},
                        // )
                      ],
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width - 40,
                        margin: EdgeInsets.only(left: 15, top: 15, bottom: 10),
                        child: Text(
                            snapshot.data!.docs[index].get('description'))),
                    // Container(
                    //   alignment: Alignment.centerLeft,
                    //   height: 40,
                    //   width: MediaQuery.of(context).size.width - 30,
                    //   decoration: BoxDecoration(
                    //       border: Border(
                    //           top: BorderSide(width: 1, color: Colors.grey))),
                    //   child: Text(
                    //     "Add class comment",
                    //     style: TextStyle(fontSize: 12, color: Colors.grey),
                    //   ),
                    // )
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
