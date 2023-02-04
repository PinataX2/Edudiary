// // ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final user = FirebaseAuth.instance.currentUser!;

//   // document IDS
//   List<String> docIDs = [];

//   // get deoc ids

//   // Future getDocID() async {
//   //   await FirebaseFirestore.instance.collectionGroup('users').get().then(
//   //         (snapshot) => snapshot.docs.forEach(
//   //           (document) {
//   //             print(document.reference);
//   //             docIDs.add(document.reference.id);
//   //           },
//   //         ),
//   //       );
//   // }
//   Future getDocID() async {
//     CollectionReference users = FirebaseFirestore.instance.collection('users');
      
//   }
//   // @override
//   // void initState() {
//   //   getDocID();
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Signed In as : ' + user.email!),
//               MaterialButton(
//                 onPressed: () {
//                   FirebaseAuth.instance.signOut();
//                 },
//                 color: Colors.deepPurple[200],
//                 // ignore: prefer_const_constructors
//                 child: Text('Sign Out'),
//               ),
//               Expanded(
//                 child: FutureBuilder(
//                   future: getDocID(),
//                   builder: (context, snapshot) {
//                     return ListView.builder(
//                       itemCount: docIDs.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           title: GetUserName(
//                             documentId: docIDs[index],
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
