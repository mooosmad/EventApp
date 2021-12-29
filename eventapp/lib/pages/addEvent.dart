// ignore_for_file: prefer_const_constructors, file_names, avoid_unnecessary_containers

import 'dart:math';

import 'package:eventapp/common/constant.dart';
import 'package:date_format/date_format.dart';
import 'package:eventapp/services/firestore/evenement.dart';
import 'package:eventapp/services/firestore/gestionEvent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddEvent extends StatefulWidget {
  final User? user;
  const AddEvent({Key? key, this.user}) : super(key: key);

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  DateTime? dateDebut = DateTime.now();
  DateTime? dateFin = DateTime.now();
  String? titre = "";

  List<Color> colors = [Colors.red, Colors.blue, Colors.purple, Colors.teal];
  int colorSelectioner = Random().nextInt(3);
  String? colorEvent;
  String? description = "";
  GestionEvent? gestionEvent;
  final key = GlobalKey<FormState>();

  getColor() {
    if (colors[colorSelectioner] == Colors.red) {
      return "red";
    } else if (colors[colorSelectioner] == Colors.blue) {
      return "blue";
    } else if (colors[colorSelectioner] == Colors.purple) {
      return "purple";
    } else {
      return "teal";
    }
  }

  @override
  void initState() {
    colorEvent = getColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        title: Text("Créer votre évènement"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (titre!.trim() != "" && description!.trim() != "") {
            setState(() {
              gestionEvent = GestionEvent(uid: widget.user!.uid);
            });

            Evenement evenement = Evenement(
              dateDebut: dateDebut.toString(),
              dateFin: dateFin.toString(),
              description: description,
              nom: titre,
              urlDescription: "",
              color: colorEvent,
            );
            gestionEvent!.addEvent(evenement);
            Fluttertoast.showToast(msg: "Evènement créé avec succès");
            Navigator.pop(context);
          } else {
            showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text("Impossible"),
                    content: Text("Veillez remplir les champs obligatoires"),
                    actions: [
                      CupertinoDialogAction(
                        child: Text("Compris"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                });
          }
        },
        child: Icon(Icons.create_rounded),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 13),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.orange.withOpacity(0.6)),
                    ),
                    onPressed: () {
                      dialog();
                    },
                    icon: Icon(Icons.date_range),
                    label: Text(" Selectionner votre date"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    dateContainer("Debut", dateDebut!),
                    dateContainer("Fin", dateFin!),
                  ],
                ),
                SizedBox(height: 15),
                tousFait("Titre", "Entrez le nom de votre évènemt", (t) {
                  setState(() {
                    titre = t;
                  });
                }, (v) {}),
                SizedBox(height: 15),
                tousFait("Description", "Entrez une description", (d) {
                  setState(() {
                    description = d;
                  });
                }, (v) {}),
                SizedBox(height: 20),
                Text(
                  "Selectionnez une couleur pour votre évènement (facultatif)",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: List.generate(colors.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          colorSelectioner = index;
                          colorEvent = getColor();
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        width: 40,
                        height: 40,
                        child: Center(
                          child: colorSelectioner == index
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors[index],
                        ),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getDate(DateTime date) {
    return formatDate(date, [dd, '-', mm, '-', yyyy]);
  }

  Widget dateContainer(String text, DateTime date) {
    return Container(
      child: Row(
        children: [
          Text(
            "$text : ",
            style: TextStyle(color: Colors.grey),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
            decoration: BoxDecoration(
              color: lightbackground,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Text(
              getDate(date),
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget tousFait(String title, String hintText, Function(String s)? onchanged,
      String? Function(String? s)? validator) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 9),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                width: 1.5,
                color: Colors.grey,
              ),
            ),
            child: TextFormField(
              maxLines: null,
              style: TextStyle(color: Colors.white, fontSize: 18),
              onChanged: onchanged,
              validator: validator,
              cursorHeight: 20,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  dialog() {
    showDialog(
        context: context,
        builder: (context) {
          DateTime datedeb = DateTime(0000);
          DateTime datefin = DateTime(0000);
          return SimpleDialog(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: SfDateRangePicker(
                  selectionMode: DateRangePickerSelectionMode.range,
                  todayHighlightColor: Colors.amber,
                  selectionColor: Colors.amber,
                  rangeSelectionColor: Colors.orange.withOpacity(0.4),
                  startRangeSelectionColor: Colors.orange,
                  endRangeSelectionColor: Colors.orange,
                  onSelectionChanged: (arg) {
                    setState(() {
                      datedeb = arg.value.startDate;
                      if (arg.value.endDate != null) {
                        datefin = arg.value.endDate;
                      }
                    });
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  if (datefin != DateTime(0000) && datedeb != DateTime(0000)) {
                    setState(() {
                      dateDebut = datedeb;
                      dateFin = datefin;
                    });
                    Navigator.pop(context);
                  } else {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text("Incorrect"),
                          content: Text("Veillez choisir une plage de date"),
                          actions: [
                            CupertinoDialogAction(
                              child: Text("Compris"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text("valider"),
              )
            ],
          );
        });
  }
}

// SfDateRangePicker(
//           selectionMode: DateRangePickerSelectionMode.range,
//           onSelectionChanged: (arg) {
//             print(arg.value);
//           },
//           backgroundColor: Colors.white,
//         ),
