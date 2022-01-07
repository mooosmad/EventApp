// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/common/constant.dart';
import 'package:eventapp/common/loading.dart';
import 'package:eventapp/services/firestore/evenement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';

class AcceptInvitaion extends StatefulWidget {
  const AcceptInvitaion({Key? key}) : super(key: key);

  @override
  _AcceptInvitaionState createState() => _AcceptInvitaionState();
}

class _AcceptInvitaionState extends State<AcceptInvitaion> {
  User? user;

  Color getColor(String colorEvent) {
    if (colorEvent == "red") {
      return Colors.red;
    } else if (colorEvent == "blue") {
      return Colors.blue;
    } else if (colorEvent == "purple") {
      return Colors.purple;
    } else {
      return Colors.teal;
    }
  }

  Evenement getEventInvit(DocumentSnapshot snapshot) {
    return Evenement(
      dateDebut: (snapshot.data() as dynamic)["date debut"],
      description: (snapshot.data() as dynamic)["description"],
      nom: (snapshot.data() as dynamic)["nomEvenement"],
      urlDescription: (snapshot.data() as dynamic)["urlDescription"],
      dateFin: (snapshot.data() as dynamic)["date fin"],
      color: (snapshot.data() as dynamic)["color"],
      dateCreation: (snapshot.data() as dynamic)["date de creation"],
    );
  }

  UserInfo infoUser(DocumentSnapshot snapshot) {
    return UserInfo(
      photoUrl: (snapshot.data() as dynamic)["photoProfile"],
      email: (snapshot.data() as dynamic)["email"],
    );
  }

  verifyIsUserIsConnected() {
    user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Fluttertoast.showToast(msg: "Connectez-vous à un compte d'abord");

      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    if (mounted) {
      verifyIsUserIsConnected();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return user != null
        ? Scaffold(
            backgroundColor: background,
            appBar: AppBar(
              title: Text("Invitations"),
              backgroundColor: lightbackground,
              elevation: 0,
              centerTitle: true,
            ),
            body: Container(
              padding: const EdgeInsets.only(
                right: 15,
                left: 15,
              ),
              child: StreamBuilder<Evenement>(
                  stream: FirebaseFirestore.instance
                      .collection("Evenements")
                      .doc(arguments["uid"])
                      .collection("MesEvenements")
                      .doc(arguments["date de creation"])
                      .snapshots()
                      .map(getEventInvit),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final res = snapshot.data;
                      print(res!.color);
                      return Center(
                        child: Stack(
                          children: [
                            ShaderMask(
                              shaderCallback: (rect) {
                                return const LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.black, Colors.transparent],
                                ).createShader(
                                  Rect.fromLTRB(0, 0, rect.width, rect.height),
                                );
                              },
                              blendMode: BlendMode.dstIn,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //titre
                                    Container(
                                      height: 80,
                                      width: 220,
                                      child: Text(
                                        res.nom!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),

                                    //description
                                    Container(
                                      height: 130,
                                      child: Text(
                                        res.description!,
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: getColor(res.color!),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20.0),
                                    bottom: Radius.circular(20.0),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 0.2,
                                      offset: Offset(1.0, 1.0),
                                      spreadRadius: 0.2,
                                      color: Color(0x00ffffff),
                                    ),
                                  ],
                                ),
                                height: 280,
                              ),
                            ),
                            Positioned(
                              right: 20,
                              top: 30,
                              child: StreamBuilder<UserInfo>(
                                  stream: FirebaseFirestore.instance
                                      .collection("users")
                                      .doc((arguments["uid"]))
                                      .snapshots()
                                      .map(infoUser),
                                  builder: (context, snap) {
                                    if (snap.hasData) {
                                      final resultat = snap.data;
                                      return Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: background,
                                          shape: BoxShape.circle,
                                          image: resultat!.photoUrl != ""
                                              ? DecorationImage(
                                                  image: NetworkImage(
                                                      resultat.photoUrl!),
                                                  fit: BoxFit.cover,
                                                )
                                              : null,
                                        ),
                                        child: Center(
                                          child: resultat.photoUrl != ""
                                              ? null
                                              : Text(
                                                  resultat.email![0]
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 19,
                                                  ),
                                                ),
                                        ),
                                      );
                                    }
                                    return Container();
                                  }),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Loading();
                    }
                  }),
            ),
          )
        : Container();
  }
}

class UserInfo {
  String? photoUrl;
  String? email;
  UserInfo({this.photoUrl, this.email});
}
