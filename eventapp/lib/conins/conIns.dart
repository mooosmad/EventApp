// ignore_for_file: prefer_const_constructors, file_names, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:eventapp/common/constant.dart';
import 'package:eventapp/conins/login.dart';
import 'package:eventapp/conins/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";

class ConIns extends StatefulWidget {
  const ConIns({Key? key}) : super(key: key);

  @override
  _ConInsState createState() => _ConInsState();
}

class _ConInsState extends State<ConIns> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    child: Image.asset("assets/conins.png"),
                    height: 250,
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Gérez votre organisation comme des pros",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Créer des évènements et partager les avec vos amis et proches afin de les tenir informé . Vous pouvez aussi rejoindre vos amis dans leurs différents évènements",
                    style: GoogleFonts.alegreya(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: lightbackground,
              ),
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) {
                            return Register();
                          }),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white.withOpacity(0.8),
                        ),
                        height: 60,
                        child: Center(
                          child: Text(
                            "Inscription",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) {
                            return Login();
                          }),
                        );
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            "Connexion",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
