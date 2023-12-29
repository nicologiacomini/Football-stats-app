import 'dart:async';
import 'package:betstats_app/pages/stats_page.dart';
import 'package:betstats_app/read_data/get_teams.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class GamesPage extends StatefulWidget {
  const GamesPage(
      {super.key, required this.championship, required this.lastDay});

  final String championship;
  final int lastDay;

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  bool loadingGame = true;
  List<String> dayList = [];
  List<String> games = [];
  String? selectedDay;
  int championshipLastDay = 1;

  bool isLoaded = false;

  final Map<String, String> conversion = {
    'Serie A': 'seriea',
    'Premier League': 'premier',
    'Liga': 'liga',
    'Bundesliga': 'bundesliga',
    'Ligue 1': 'ligue1',
  };

  Future getDayList() async {
    championshipLastDay = widget.lastDay;

    for (int i = 1; i <= championshipLastDay; i++) {
      dayList.add(i.toString());
    }
    if (!isLoaded) {
      selectedDay = dayList.last;
    }
  }

  Future getGames() async {
    // await Future.delayed(const Duration(milliseconds: 500));
    String? championship = conversion[widget.championship];
    await FirebaseFirestore.instance
        .collection(championship!)
        .doc(selectedDay)
        .collection('games')
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              games.add(document.reference.id);
            },
          ),
        );
  }

  @override
  void initState() {
    isLoaded = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Color.fromARGB(255, 4, 53, 157),
        ),
        title: Image.asset(
          "assets/images/title.png",
          height: 50.0,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 15.0),
            child: Text(
              widget.championship,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 4, 53, 157),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                future: getDayList(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(
                        bottom: 10.0,
                        left: 20.0,
                      ),
                      child: SizedBox(
                        width: 250,
                        child: Text("Error: ${snapshot.error}"),
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting &&
                      !isLoaded) {
                    return Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(
                        bottom: 10.0,
                        left: 20.0,
                      ),
                      child: const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  isLoaded = true;
                  // if (!isLoaded) {

                  //   selectedDay = dayList.last;
                  // }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Giornata:',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color.fromARGB(255, 4, 53, 157),
                        ),
                      ),
                      Container(
                        width: 67.0,
                        height: 40.0,
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Color(0xFFB8FF55),
                        ),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 10.0),
                        child: SizedBox(
                          width: 230,
                          child: DropdownButton<String>(
                            underline: Container(
                              color: const Color(0xFFB8FF55),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down_rounded,
                              color: Color.fromARGB(255, 4, 53, 157),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            dropdownColor: const Color(0xFFB8FF55),
                            value: selectedDay,
                            items: dayList
                                .map(
                                  (item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        color: Color.fromARGB(255, 4, 53, 157),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (item) => setState(
                              () {
                                selectedDay = item ?? dayList.last;
                                dayList.clear();
                                games.clear();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          const Divider(
            height: 20,
            thickness: 1,
            indent: 10,
            endIndent: 10,
            color: Color.fromARGB(255, 4, 53, 157),
          ),
          Expanded(
            child: FutureBuilder(
              future: getGames(),
              builder: (context, snapshot) {
                return ListView.builder(
                  // shrinkWrap select a fixed max size that listview cannot overtake
                  shrinkWrap: true,
                  itemCount: games.length,
                  itemBuilder: (context, index) {
                    String? championship = conversion[widget.championship];
                    return ListTile(
                      title: GetTeams(
                        documentId: games[index],
                        championship: championship!,
                        day: selectedDay!,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return StatsPage(
                                game: games[index],
                                championship: championship,
                                day: selectedDay!,
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
