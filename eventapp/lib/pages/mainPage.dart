// ignore_for_file: prefer_const_constructors, avoid_print, file_names

import 'dart:ui';

import 'package:eventapp/pages/details.dart';
import 'package:eventapp/pages/home.dart';
import 'package:eventapp/pages/setting.dart';
import 'package:eventapp/widget/bottombar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class MainPage extends StatefulWidget {
  final User? user;
  const MainPage({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  final pages = <Widget>[
    Pagehome(),
    ProfilePage(),
    Setting(),
  ];

  @override
  void initState() {
    pages[0] = Pagehome(
      user: widget.user,
    );
    pages[2] = Setting(
      user: widget.user,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      // ),
      extendBody: true,
      body: pages[index],
      bottomNavigationBar: PoyBottomBar(
        index: index,
        changed: (int index) {
          setState(() {
            this.index = index;
          });
        },
      ),
    );
  }

  void onChangedTab(int index) {
    setState(() {
      this.index = index;
    });
  }

  void show() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.92,
          margin: const EdgeInsets.all(1),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 20.0,
                sigmaY: 20.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  // border: Border.all(
                  //   color: Colors.black26,
                  //   width: 0.5,
                  // ),
                ),
                child: Column(
                  children: [
                    Center(
                      child: FractionallySizedBox(
                        widthFactor: 0.10,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                            // border: Border.all(
                            //   color: Colors.black12,
                            //   width: 0.5,
                            // ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Bientot',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
