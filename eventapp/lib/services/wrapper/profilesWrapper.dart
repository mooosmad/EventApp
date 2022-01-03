// ignore_for_file: prefer_const_constructors, file_names

import 'package:eventapp/common/constant.dart';
import 'package:eventapp/pages/mainPage.dart';
import 'package:eventapp/pages/profiles.dart';
import 'package:eventapp/widget/dialogProfileWrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class ProfileWrapper extends StatefulWidget {
  final User? user;
  const ProfileWrapper({Key? key, this.user}) : super(key: key);

  @override
  _ProfileWrapperState createState() => _ProfileWrapperState();
}

class _ProfileWrapperState extends State<ProfileWrapper> {
  choix(context, user) {}

  @override
  void initState() {
    if (mounted) {
      Future.delayed(Duration.zero, () {
        showCupertinoDialog(
            context: context,
            builder: (context) {
              return WillPopScope(
                onWillPop: () async => false,
                child: DialogProfileWrapp(
                  maintenantFunction: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return Profiles(user: widget.user);
                      }),
                      (route) => false,
                    );
                  },
                  plutardFunction: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return MainPage(user: widget.user);
                      }),
                      (route) => false,
                    );
                  },
                ),
              );
            });
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: background,
        body: Container(),
      ),
    );
  }
}
