  // ignore_for_file: prefer_const_constructors

  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:flutter/material.dart';
  import 'package:my_project/Creates/add_group.dart';
  import 'package:my_project/Creates/join_school.dart';
  import 'package:my_project/Pages/Social/join_yearbook.dart';
  import 'package:my_project/Pages/Social/widgets/post_card.dart';
  import '../../Creates/create_yearbook.dart';
  import '../../Creates/select_yearbook.dart';
  import '../GClassroom/screens/select_a_school.dart';
  import 'choose_yearbook.dart';

  class FeedScreen extends StatefulWidget {
    String yearbookid;
    FeedScreen({super.key, required this.yearbookid});

    @override
    State<FeedScreen> createState() => _FeedScreenState();
  }

  class _FeedScreenState extends State<FeedScreen> {
    @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFD4E7FE),
            title: Text(
              'Yearbooks',
              style: TextStyle(color: Color(0XFF343E87)),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          title: Text('Create'),
                          children: [
                            SimpleDialogOption(
                              padding: EdgeInsets.all(20),
                              child: const Text("New Post"),
                              onPressed: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SelectYearbook(),
                                  ),
                                );
                              },
                            ),
                            SimpleDialogOption(
                              padding: EdgeInsets.all(20),
                              child: const Text("Add a Yearbook"),
                              onPressed: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CreateYearbook(),
                                  ),
                                );
                              },
                            ),
                            SimpleDialogOption(
                              padding: EdgeInsets.all(20),
                              child: const Text("Join a Yearbook"),
                              onPressed: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        JoinYearBook(),
                                  ),
                                );
                              },
                            ),
                            SimpleDialogOption(
                              padding: EdgeInsets.all(20),
                              child: const Text("View another Yearbook"),
                              onPressed: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ChooseYearbook(),
                                  ),
                                );
                              },
                            ),
                            SimpleDialogOption(
                              padding: EdgeInsets.all(20),
                              child: const Text("Cancel"),
                              onPressed: () async {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
                icon: Icon(
                  Icons.add,
                  color: Color(0XFF343E87),
                ),
              )
            ],
          ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .where('yearbookId', isEqualTo: widget.yearbookid)
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
                itemBuilder: (context, index) => PostCard(
                  snap: snapshot.data!.docs[index].data(),
                ),
              );
            },
          ),
        ),
      );
    }
  }
