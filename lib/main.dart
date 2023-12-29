import 'package:betstats_app/firebase_options.dart';
import 'package:betstats_app/pages/home_page.dart';
import 'package:betstats_app/pages/login_page.dart';
import 'package:betstats_app/pages/route_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:betstats_app/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BetStats",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: mycolor,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const RoutePage(),
        "/home": (context) => const HomePage(),
        "/login": (context) => const LoginPage()
      },
    );
  }
}
