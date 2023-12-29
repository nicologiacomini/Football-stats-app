import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key, required this.championship, required this.team});
  final String championship;
  final String team;

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  int? nGoalScored;
  int? nGoalConceded;
  int? nDraw;
  int? nFouls;
  double? nFoulsGame;
  int? nGames;
  double? nGoalConcededGame;
  double? nGoalScoredGame;
  int? nRed;
  int? nShot;
  double? nShotGame;
  int? nShotTarget;
  double? nShotTargetGame;
  int? nWin;
  int? nLose;
  int? nYellow;
  double? nYellowGame;

  List<dynamic>? outcomeOldGames = [];
  List<dynamic>? listOldGames = [];

  Future getDataTeam() async {
    await FirebaseFirestore.instance
        .collection(widget.championship)
        .doc(widget.team)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        nGoalScored = data['nGoalScored'];
        nGoalConceded = data['nGoalConceded'];
        nDraw = data['nDraw'];
        nFouls = data['nFouls'];
        nLose = data['nLose'];
        nFoulsGame = data['nFoulsGame'];
        nGames = data['nGames'];
        nGoalConcededGame = data['nGoalConcededGame'];
        nGoalScoredGame = data['nGoalScoredGame'];
        nRed = data['nRed'];
        nShot = data['nShot'];
        nShotGame = data['nShotGame'];
        nShotTarget = data['nShotTarget'];
        nShotTargetGame = data['nShotTargetGame'];
        nWin = data['nWin'];
        nYellow = data['nYellow'];
        nYellowGame = data['nYellowGame'];
        outcomeOldGames = data['outcomeOldGames'];
        listOldGames = data['listOldGames'];
      }
    });
  }

  Padding getAmazingText(String text) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 15.0,
          color: Color.fromARGB(255, 4, 53, 157),
        ),
      ),
    );
  }

  Container getAmazingHeader(String text, bool right) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: const Color(0xFFB8FF55),
          borderRadius: right
              ? const BorderRadius.only(topRight: Radius.circular(10.0))
              : const BorderRadius.only(topLeft: Radius.circular(10.0))),
      height: 50,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 15.0,
          color: Color.fromARGB(255, 4, 53, 157),
        ),
      ),
    );
  }

  Container getAmazingHeaderCenter(String text) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xFFB8FF55),
      ),
      height: 50,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 15.0,
          color: Color.fromARGB(255, 4, 53, 157),
        ),
      ),
    );
  }

  @override
  void initState() {
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
      body: FutureBuilder(
        future: getDataTeam(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');
          if (snapshot.connectionState != ConnectionState.done) {
            return const CircularProgressIndicator();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Text(
                    'Analisi ${widget.team}',
                    style: const TextStyle(
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
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Table(
                    border: TableBorder.all(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        color: const Color.fromARGB(255, 4, 53, 157),
                        width: 1.5),
                    children: [
                      TableRow(children: [
                        getAmazingHeader('PG', false),
                        getAmazingHeaderCenter('V'),
                        getAmazingHeaderCenter('X'),
                        getAmazingHeader('P', true),
                      ]),
                      TableRow(children: [
                        getAmazingText(nGames.toString()),
                        getAmazingText(nWin.toString()),
                        getAmazingText(nDraw.toString()),
                        getAmazingText((nGames! - nDraw! - nWin!).toString()),
                      ]),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Table(
                    border: TableBorder.all(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        color: const Color.fromARGB(255, 4, 53, 157),
                        width: 1.5),
                    children: [
                      TableRow(children: [
                        getAmazingHeader('GF', false),
                        getAmazingHeaderCenter('Media GF'),
                        getAmazingHeaderCenter('GS'),
                        getAmazingHeader('Media GS', true),
                      ]),
                      TableRow(children: [
                        getAmazingText(nGoalScored.toString()),
                        getAmazingText(nGoalScoredGame.toString()),
                        getAmazingText(nGoalConceded.toString()),
                        getAmazingText(nGoalConcededGame.toString()),
                      ]),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Table(
                    border: TableBorder.all(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        color: const Color.fromARGB(255, 4, 53, 157),
                        width: 1.5),
                    children: [
                      TableRow(children: [
                        getAmazingHeader('Tiri/partita', false),
                        getAmazingHeaderCenter('Tiri in porta/partita'),
                        getAmazingHeader('Falli/partita', true),
                      ]),
                      TableRow(children: [
                        getAmazingText(nShotGame.toString()),
                        getAmazingText(nShotTargetGame.toString()),
                        getAmazingText(nFoulsGame.toString()),
                      ]),
                      TableRow(children: [
                        getAmazingHeaderCenter('Gialli'),
                        getAmazingHeaderCenter('Gialli/partita'),
                        getAmazingHeaderCenter('Rossi'),
                      ]),
                      TableRow(children: [
                        getAmazingText(nYellow.toString()),
                        getAmazingText(nYellowGame.toString()),
                        getAmazingText(nRed.toString()),
                      ]),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [getAmazingText('Partite giocate')],
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: listOldGames!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            color: outcomeOldGames![index] == "W"
                                ? Colors.greenAccent
                                : (outcomeOldGames![index] == "X"
                                    ? const Color.fromRGBO(255, 235, 59, 1)
                                    : const Color.fromARGB(255, 255, 127, 127)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              listOldGames![index],
                              style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Color.fromARGB(255, 4, 53, 157)),
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
