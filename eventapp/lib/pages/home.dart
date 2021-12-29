// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/common/constant.dart';
import 'package:eventapp/pages/addEvent.dart';
import 'package:eventapp/services/firestore/evenement.dart';
import 'package:eventapp/services/firestore/gestionEvent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pagehome extends StatefulWidget {
  final User? user;
  const Pagehome({Key? key, this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class UserInfom {
  String? email;
  String? urlPhoto;
  String? uid;
  UserInfom({
    required this.email,
    required this.urlPhoto,
    required this.uid,
  });
}

class _HomeState extends State<Pagehome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: NestedScrollView(
        headerSliverBuilder: (context, t) {
          return [showAppBar()];
        },
        body: Column(
          children: [
            Expanded(
              flex: 35,
              child: Container(
                  padding: const EdgeInsets.only(
                    right: 15,
                    left: 15,
                  ),
                  decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40.0),
                    ),
                  ),
                  child: StreamBuilder<List<Evenement>>(
                    stream:
                        GestionEvent(uid: widget.user!.uid).getAllMyEvents(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final res = snapshot.data;

                        print(res);

                        return res!.isEmpty
                            ? Center(
                                child: Text(
                                  "Aucun évènements trouvés, veuillez en créer",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                // key: PageStorageKey<String>("pageTwo"),
                                physics: BouncingScrollPhysics(),
                                itemCount: res.length,
                                itemBuilder: (BuildContext context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      showMore();
                                    },
                                    child: ShaderMask(
                                      shaderCallback: (rect) {
                                        return const LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.black,
                                            Colors.transparent
                                          ],
                                        ).createShader(
                                          Rect.fromLTRB(
                                              0, 0, rect.width, rect.height),
                                        );
                                      },
                                      blendMode: BlendMode.dstIn,
                                      child: Container(
                                        margin: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                          color: Color(0xffffffff),
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
                                        height: 300,
                                      ),
                                    ),
                                  );
                                },
                              );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.teal,
                          ),
                        );
                      }
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  showMore() {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.92,
          margin: const EdgeInsets.symmetric(vertical: 2),
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
                          'Bientôt',
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

  showAppBar() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.transparent,
                  child: const Align(
                    alignment: Alignment(0.00, 0.00),
                    child: Text(
                      'Events',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.transparent,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) {
                          return AddEvent(
                            user: widget.user,
                          );
                        }));
                      },
                      icon: Icon(
                        Icons.note_add_rounded,
                        size: 45,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
