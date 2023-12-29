import 'package:betstats_app/pages/games_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> championship = [
    'Serie A',
    'Premier League',
    'Liga',
    'Bundesliga',
    'Ligue 1'
  ];

  final Map<String, String> conversion = {
    'Serie A': 'seriea',
    'Premier League': 'premier',
    'Liga': 'liga',
    'Bundesliga': 'bundesliga',
    'Ligue 1': 'ligue1',
  };

  int? lastDay;
  Map<String, int> championshipLastDay = <String, int>{};

  Future setLastDay() async {
    conversion.forEach((key, value) async {
      await FirebaseFirestore.instance
          .collection(value)
          .doc('last-day')
          .get()
          .then((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          var entry = <String, int>{key: data['day']};
          championshipLastDay.addEntries(entry.entries);
        }
      });
    });
  }

  @override
  void initState() {
    setLastDay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/title.png",
          height: 50.0,
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: Text(
              "Campionato",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 4, 53, 157),
              ),
            ),
          ),
          const Divider(
            height: 20,
            thickness: 1,
            indent: 10,
            endIndent: 10,
            color: Color.fromARGB(255, 4, 53, 157),
          ),
          ListView.builder(
            // shrinkWrap select a fixed max size that listview cannot overtake
            shrinkWrap: true,
            itemCount: championship.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  championship[index],
                  style: const TextStyle(
                    fontSize: 20.0,
                    // fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 4, 53, 157),
                  ),
                ),
                onTap: () {
                  // send data to result page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        lastDay = championshipLastDay[championship[index]];
                        return GamesPage(
                          championship: championship[index],
                          lastDay: lastDay!,
                        );
                      },
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
