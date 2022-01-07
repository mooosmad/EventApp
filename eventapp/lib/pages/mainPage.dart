// ignore_for_file: prefer_const_constructors, avoid_print, file_names

import 'dart:ui';

import 'package:eventapp/pages/eventFriends.dart';
import 'package:eventapp/pages/home.dart';
import 'package:eventapp/pages/setting.dart';
import 'package:eventapp/widget/bottombar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';

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

  getLinkifApp() async {
    // if app is in ackground

    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      if (widget.user!.uid != dynamicLinkData.link.queryParameters["uid"]) {
        Navigator.pushNamed(
          context,
          dynamicLinkData.link.path,
          arguments: {
            "uid": dynamicLinkData.link.queryParameters["uid"],
            "date de creation":
                dynamicLinkData.link.queryParameters["dateCreation"],
          },
        );
      }
    }).onError((error) {
      print("error");
    });

    // if link open app

    PendingDynamicLinkData? pendingDynamicLinkData =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = pendingDynamicLinkData!.link;
    // une petite erreur de null safety ici mais c'est normale car au lancement normal on n'utilise pas de link
    if (deepLink != null) {
      print("existe");
      if (deepLink.queryParameters["uid"] != widget.user!.uid) {
        Navigator.pushNamed(
          context,
          deepLink.path,
          arguments: {
            "uid": deepLink.queryParameters["uid"],
            "date de creation": deepLink.queryParameters["dateCreation"],
          },
        );
      }
      if (widget.user!.uid == deepLink.queryParameters["uid"]) {
        Fluttertoast.showToast(msg: "Vous êtes le createur de cet évènement");
      }
    } else {
      print("LINK NULL");
    }
  }

  @override
  void initState() {
    pages[0] = Pagehome(
      user: widget.user,
    );
    pages[2] = Setting(
      user: widget.user,
    );

    getLinkifApp();

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
