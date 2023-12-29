import 'package:betstats_app/pages/team_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class StatsPage extends StatefulWidget {
  const StatsPage(
      {super.key,
      required this.game,
      required this.championship,
      required this.day});

  final String game;
  final String championship;
  final String day;

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  String? team1;
  String? team2;

  int? nWinT1;
  int? nWinT2;
  int? nDraw;

  int? numberGames;

  double? percT1won;
  double? percT2won;
  double? percDrew;

  double? percGoal;
  double? percNoGoal;

  double? percGoal1Half;
  double? percNoGoal1Half;

  double? percGoal2Half;
  double? percNoGoal2Half;

  double? percOver0_5;
  double? percUnder0_5;

  double? percOver1_5;
  double? percUnder1_5;

  double? percOver2_5;
  double? percUnder2_5;

  double? percOver3_5;
  double? percUnder3_5;

  double? percOver4_5;
  double? percUnder4_5;

  double? averageGoalGame;

  double? percHalfWinT1;
  double? percHalfWinT2;
  double? percDrawFirstHalf;

  double? percSameResult;

  double? perc2HalfWinT1;
  double? perc2HalfWinT2;
  double? percDraw2Half;

  List<String>? listOldGames;

  bool viewGames = false;

  Future getStats() async {
    await FirebaseFirestore.instance
        .collection(widget.championship)
        .doc(widget.day)
        .collection('games')
        .doc(widget.game)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        team1 = data['team1'];
        team2 = data['team2'];

        nWinT1 = data['nWinT1'];
        nWinT2 = data['nWinT2'];
        nDraw = data['nDraw'];

        numberGames = data['numberGames'];

        percT1won = data['percT1won'];
        percT2won = data['percT2won'];
        percDrew = data['percDrew'];

        percGoal = data['percGoal'];
        percNoGoal = data['percNoGoal'];

        percGoal1Half = data['percGoal1Half'];
        percNoGoal1Half = data['percNoGoal1Half'];

        percGoal2Half = data['percGoal2Half'];
        percNoGoal2Half = data['percNoGoal2Half'];

        percOver0_5 = data['percOver0_5'];
        percUnder0_5 = data['percUnder0_5'];

        percOver1_5 = data['percOver1_5'];
        percUnder1_5 = data['percUnder1_5'];

        percOver2_5 = data['percOver2_5'];
        percUnder2_5 = data['percUnder2_5'];

        percOver3_5 = data['percOver3_5'];
        percUnder3_5 = data['percUnder3_5'];

        percOver4_5 = data['percOver4_5'];
        percUnder4_5 = data['percUnder4_5'];

        averageGoalGame = data['averageGoalGame'];

        percHalfWinT1 = data['percHalfWinT1'];
        percHalfWinT2 = data['percHalfWinT2'];
        percDrawFirstHalf = data['percDrawFirstHalf'];

        percSameResult = data['percSameResult'];

        perc2HalfWinT1 = data['percJustSeconHalfWinT1'];
        perc2HalfWinT2 = data['percJustSeconHalfWinT2'];
        percDraw2Half = data['percJustSeconHalfDraw'];

        listOldGames = List.from(data['listOldGames']);
      }
    });
  }

  Container getAmazingContainer(double? value, String text,
      {bool? outTable, bool? bottomTableLeft, bool? bottomTableRight}) {
    int limitGood = 65;
    int limitBad = 55;
    int mediumGood = 40;
    int mediumBad = 20;
    outTable == null ? outTable = false : outTable = true;
    bottomTableLeft == null ? bottomTableLeft = false : bottomTableLeft = true;
    bottomTableRight == null
        ? bottomTableRight = false
        : bottomTableRight = true;
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: outTable
              ? const BorderRadius.only(
                  bottomRight: Radius.circular(10.0),
                  topRight: Radius.circular(10.0))
              : bottomTableRight
                  ? const BorderRadius.only(bottomRight: Radius.circular(10.0))
                  : bottomTableLeft
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(10.0))
                      : null,
          color: (value! >= limitGood)
              ? const Color.fromARGB(197, 0, 255, 47)
              : (value > mediumGood)
                  ? const Color.fromARGB(183, 172, 229, 16)
                  : (value > mediumBad)
                      ? const Color.fromARGB(210, 222, 218, 33)
                      : (value > limitBad)
                          ? const Color.fromARGB(189, 255, 175, 38)
                          : const Color.fromARGB(255, 255, 127, 127)),
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
        future: getStats(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
              child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.all(20.0)),
                            backgroundColor: MaterialStatePropertyAll(
                              (numberGames! >= 8)
                                  ? const Color.fromARGB(197, 0, 255, 47)
                                  : (numberGames! < 3)
                                      ? const Color.fromARGB(255, 255, 127, 127)
                                      : const Color.fromRGBO(255, 235, 59, 1),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              viewGames = !viewGames;
                            });
                          },
                          child: Text(
                            '$numberGames partite analizzate',
                            style: const TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 4, 53, 157),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: viewGames,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listOldGames!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            listOldGames![index],
                            style: const TextStyle(
                                fontSize: 15.0,
                                color: Color.fromARGB(255, 4, 53, 157)),
                          ),
                        );
                      }),
                ),
                const Divider(
                  height: 20,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                  color: Color.fromARGB(255, 4, 53, 157),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [getAmazingText('Analisi risultato finale')],
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(3),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(3)
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder.all(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        color: const Color.fromARGB(255, 4, 53, 157),
                        width: 1.5),
                    children: [
                      TableRow(children: [
                        TableCell(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: Color(0xFFB8FF55),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0))),
                            height: 50,
                            width: 128,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  shadowColor: Colors.transparent),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$team1',
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      color: Color.fromARGB(255, 4, 53, 157),
                                    ),
                                  ),
                                  const Icon(
                                    size: 15.0,
                                    Icons.leaderboard_rounded,
                                    color: Color.fromARGB(255, 4, 53, 157),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return TeamPage(
                                      championship: widget.championship,
                                      team: team1!,
                                    );
                                  }),
                                );
                              },
                            ),
                          ),
                        ),
                        getAmazingText('X'),
                        TableCell(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: Color(0xFFB8FF55),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0))),
                            height: 50,
                            width: 128,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  shadowColor: Colors.transparent),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$team2 ',
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      color: Color.fromARGB(255, 4, 53, 157),
                                    ),
                                  ),
                                  const Icon(
                                    size: 15.0,
                                    Icons.leaderboard_rounded,
                                    color: Color.fromARGB(255, 4, 53, 157),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return TeamPage(
                                      championship: widget.championship,
                                      team: team2!,
                                    );
                                  }),
                                );
                              },
                            ),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        getAmazingContainer(percT1won, '$percT1won%\n($nWinT1)',
                            bottomTableLeft: true),
                        getAmazingContainer(percDrew, '$percDrew%\n($nDraw)'),
                        getAmazingContainer(percT2won, '$percT2won%\n($nWinT2)',
                            bottomTableRight: true),
                      ])
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
                        getAmazingText('Goal'),
                        getAmazingText('NO Goal'),
                        getAmazingText('Over 2.5'),
                        getAmazingText('Under 2.5'),
                      ]),
                      TableRow(children: [
                        getAmazingContainer(percGoal, '$percGoal%',
                            bottomTableLeft: true),
                        getAmazingContainer(percNoGoal, '$percNoGoal%'),
                        getAmazingContainer(percOver2_5, '$percOver2_5%'),
                        getAmazingContainer(percUnder2_5, '$percUnder2_5%',
                            bottomTableRight: true),
                      ])
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
                        getAmazingText('Over 0.5'),
                        getAmazingText('Under 0.5'),
                        getAmazingText('Over 1.5'),
                        getAmazingText('Under 1.5'),
                      ]),
                      TableRow(children: [
                        getAmazingContainer(percOver0_5, '$percOver0_5%',
                            bottomTableLeft: true),
                        getAmazingContainer(percUnder0_5, '$percUnder0_5%'),
                        getAmazingContainer(percOver1_5, '$percOver1_5%'),
                        getAmazingContainer(percUnder1_5, '$percUnder1_5%',
                            bottomTableRight: true),
                      ])
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
                        getAmazingText('Over 3.5'),
                        getAmazingText('Under 3.5'),
                        getAmazingText('Over 4.5'),
                        getAmazingText('Under 4.5'),
                      ]),
                      TableRow(children: [
                        getAmazingContainer(percOver3_5, '$percOver3_5%',
                            bottomTableLeft: true),
                        getAmazingContainer(percUnder3_5, '$percUnder3_5%'),
                        getAmazingContainer(percOver4_5, '$percOver4_5%'),
                        getAmazingContainer(percUnder4_5, '$percUnder4_5%',
                            bottomTableRight: true),
                      ])
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(3),
                      1: FlexColumnWidth(),
                    },
                    border: TableBorder.all(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        color: const Color.fromARGB(255, 4, 53, 157),
                        width: 1.5),
                    children: [
                      TableRow(children: [
                        getAmazingText('Media goal a partita'),
                        getAmazingText('$averageGoalGame'),
                      ]),
                      TableRow(children: [
                        getAmazingText('Stesso (1/x/2) 1° e 2° tempo'),
                        getAmazingContainer(percSameResult, '$percSameResult%',
                            bottomTableRight: true),
                      ])
                    ],
                  ),
                ),
                // Container(
                //   margin: const EdgeInsets.all(10.0),
                //   child: Table(
                //     columnWidths: const <int, TableColumnWidth>{
                //       0: FlexColumnWidth(3),
                //       1: FlexColumnWidth(),
                //     },
                //     border: TableBorder.all(
                //         borderRadius:
                //             const BorderRadius.all(Radius.circular(10.0)),
                //         color: const Color.fromARGB(255, 4, 53, 157),
                //         width: 1.5),
                //     children: [
                //       TableRow(children: [
                //         getAmazingText('Stesso risultato 1° e 2° tempo: '),
                //         getAmazingContainer(percSameResult, '$percSameResult',
                //             outTable: true),
                //       ]),
                //     ],
                //   ),
                // ),
                const Divider(
                  height: 20,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                  color: Color.fromARGB(255, 4, 53, 157),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [getAmazingText('Analisi solo 1° tempi')],
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
                        getAmazingText('$team1'),
                        getAmazingText('$team2'),
                        getAmazingText('X'),
                      ]),
                      TableRow(children: [
                        getAmazingContainer(percHalfWinT1, '$percHalfWinT1%',
                            bottomTableLeft: true),
                        getAmazingContainer(percHalfWinT2, '$percHalfWinT2%'),
                        getAmazingContainer(
                            percDrawFirstHalf, '$percDrawFirstHalf%',
                            bottomTableRight: true),
                      ])
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
                        getAmazingText('Goal'),
                        getAmazingText('NO Goal'),
                      ]),
                      TableRow(children: [
                        getAmazingContainer(percGoal1Half, '$percGoal1Half%',
                            bottomTableLeft: true),
                        getAmazingContainer(
                            percNoGoal1Half, '$percNoGoal1Half%',
                            bottomTableRight: true),
                      ])
                    ],
                  ),
                ),
                const Divider(
                  height: 20,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                  color: Color.fromARGB(255, 4, 53, 157),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [getAmazingText('Analisi solo 2° tempi')],
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
                        getAmazingText('$team1'),
                        getAmazingText('$team2'),
                        getAmazingText('X'),
                      ]),
                      TableRow(children: [
                        getAmazingContainer(perc2HalfWinT1, '$perc2HalfWinT1%',
                            bottomTableLeft: true),
                        getAmazingContainer(perc2HalfWinT2, '$perc2HalfWinT2%'),
                        getAmazingContainer(percDraw2Half, '$percDraw2Half%',
                            bottomTableRight: true),
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
                        getAmazingText('Goal'),
                        getAmazingText('NO Goal'),
                      ]),
                      TableRow(children: [
                        getAmazingContainer(percGoal2Half, '$percGoal2Half%',
                            bottomTableLeft: true),
                        getAmazingContainer(
                            percNoGoal2Half, '$percNoGoal2Half%',
                            bottomTableRight: true),
                      ])
                    ],
                  ),
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
}
