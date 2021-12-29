// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, file_names

import 'package:eventapp/common/loading.dart';
import 'package:eventapp/conins/conIns.dart';
import 'package:eventapp/pages/mainPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  late User? user;
  bool load = true;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    setState(() {
      user;
      load = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return load
        ? Loading()
        : user != null
            ? MainPage(
                user: user,
              )
            : ConIns();
  }
}
