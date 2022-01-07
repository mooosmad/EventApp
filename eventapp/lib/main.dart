// ignore_for_file: prefer_const_constructors

import 'package:eventapp/redirectionPage/acceptInvitaion.dart';
import 'package:eventapp/services/wrapper/authWrapper.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Event app",
      theme: ThemeData(
        bottomAppBarColor: Colors.transparent,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.lime.shade600,
        ),
      ),
      debugShowCheckedModeBanner: false,
      // home: Profiles(),
      home: AuthWrapper(),
      routes: {
        "/invitationPage": (context) => AcceptInvitaion(),
      },
    );
  }
}
