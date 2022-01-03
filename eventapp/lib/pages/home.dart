// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'dart:ui';
import 'package:eventapp/common/constant.dart';
import 'package:eventapp/common/loading.dart';
import 'package:eventapp/pages/addEvent.dart';
import 'package:eventapp/services/firestore/evenement.dart';
import 'package:eventapp/services/firestore/gestionEvent.dart';
import 'package:eventapp/services/shareUrl/shareUrl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pagehome extends StatefulWidget {
  final User? user;
  const Pagehome({Key? key, this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Pagehome> {
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
                                physics: BouncingScrollPhysics(),
                                itemCount: res.length,
                                itemBuilder: (BuildContext context, index) {
                                  Color colorEvent =
                                      getColor(res[index].color!);
                                  return GestureDetector(
                                    onTap: () {
                                      showMore(res[index]);
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
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            //titre
                                            Container(
                                              height: 80,
                                              child: Text(
                                                res[index].nom!,
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
                                                res[index].description!,
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
                                          color: colorEvent,
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
                                  );
                                },
                              );
                      } else {
                        return Loading();
                      }
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  showMore(Evenement evenement) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Stack(
          children: [
            Container(
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
                      border: Border.all(
                        color: Colors.black26,
                        width: 0.5,
                      ),
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
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    informationContainer(
                                        date: evenement.dateDebut,
                                        titre: "Debut"),
                                    informationContainer(
                                      date: evenement.dateFin,
                                      titre: "Fin",
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.72),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        evenement.nom!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        evenement.description!,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              child: GestureDetector(
                onTap: () {
                  ShareUrl().sendUrl();
                },
                child: Container(
                  padding: EdgeInsets.all(9),
                  margin: EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: getColor(evenement.color!),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.share,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ),
              right: 0,
              bottom: 10,
            ),
          ],
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

  informationContainer({String? date, String? titre}) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 9,
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.72),
        borderRadius: BorderRadius.circular(20),
      ),
      width: 150,
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titre!,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Icon(
            Icons.calendar_today_rounded,
            color: Colors.white70,
            size: 30,
          ),
          Text(
            date!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
