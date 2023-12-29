import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class GetTeams extends StatelessWidget {
  const GetTeams(
      {super.key,
      required this.documentId,
      required this.championship,
      required this.day});

  final String documentId;
  final String championship;
  final String day;

  @override
  Widget build(BuildContext context) {
    CollectionReference games = FirebaseFirestore.instance
        .collection(championship)
        .doc(day)
        .collection('games');
    return FutureBuilder<DocumentSnapshot>(
      future: games.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            '${data['team1']} - ${data['team2']}',
            style: const TextStyle(
              fontSize: 20.0,
              color: Color.fromARGB(255, 4, 53, 157),
            ),
          );
        }
      },
    );
  }
}
