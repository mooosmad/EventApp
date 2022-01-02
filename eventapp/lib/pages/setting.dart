// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/common/constant.dart';
import 'package:eventapp/common/loading.dart';
import 'package:eventapp/conins/conIns.dart';
import 'package:eventapp/pages/profiles.dart';
import 'package:eventapp/services/authentification/authentification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class Setting extends StatefulWidget {
  final User? user;
  const Setting({Key? key, this.user}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  Authentification authentification = Authentification();
  String username = "";
  String imageUrl = "";
  String email = "";
  bool load = true;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("users");

  getInfo() {
    collectionReference.doc(widget.user!.uid).get().then((doc) {
      setState(() {
        username = (doc.data() as dynamic)["nom"] +
            " " +
            (doc.data() as dynamic)["prenom"];
        imageUrl = (doc.data() as dynamic)["photoProfile"];
        email = (doc.data() as dynamic)["email"];
        load = false;
      });
    });
  }

  @override
  void initState() {
    getInfo();
    print(widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return load
        ? Loading()
        : Scaffold(
            backgroundColor: background,
            body: NestedScrollView(
              headerSliverBuilder: (context, b) {
                return [
                  SliverAppBar(
                    pinned: true,
                    automaticallyImplyLeading: false,
                    backgroundColor: background,
                    expandedHeight: 150,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.only(left: 25, bottom: 16),
                      title: Text(
                        'Réglages',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: Container(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      color: Color(0xFF262525),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) {
                            return Profiles(
                              user: widget.user,
                            );
                          }));
                        },
                        title: Text(
                          username,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          widget.user!.email!,
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing:
                            Icon(Icons.qr_code_outlined, color: Colors.grey),
                        leading: Container(
                          padding: EdgeInsets.all(8),
                          child: CircleAvatar(
                            backgroundImage:
                                imageUrl != "" ? NetworkImage(imageUrl) : null,
                            child: imageUrl != ""
                                ? null
                                : Text(email[0].toUpperCase()),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    block(
                      Icons.settings_input_composite,
                      Colors.teal,
                      "Nombres d'evènements",
                      () {},
                    ),
                    block(
                      CupertinoIcons.square_stack_3d_down_right_fill,
                      Colors.yellow,
                      "Evènements acceptés",
                      () {},
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    block(
                      Icons.info,
                      Colors.blue,
                      "Aide",
                      () {},
                    ),
                    block(
                      Icons.share,
                      Colors.orange,
                      "Recommander à un ami",
                      () {},
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    block(
                      Icons.logout_rounded,
                      Colors.red,
                      "Déconnexion",
                      () {
                        deconnexion();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  deconnexion() {
    showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Déconnexion"),
            content: Text("Voulez-vous vraiment vous déconnectez?"),
            actions: [
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text("oui"),
                onPressed: () {
                  authentification.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return ConIns();
                  }));
                },
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("non"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  block(IconData icon, Color color, String text, void Function()? onTap) {
    return Container(
      color: Color(0xFF262525),
      child: ListTile(
        onTap: onTap,
        title: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        trailing: Icon(Icons.navigate_next_sharp, color: Colors.grey),
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon),
        ),
      ),
    );
  }
}
