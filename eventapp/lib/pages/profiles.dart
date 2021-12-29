// ignore_for_file: prefer_const_constructors, invalid_use_of_visible_for_testing_member, avoid_print

import 'dart:io';

import 'package:eventapp/common/constant.dart';
import 'package:eventapp/common/formulaire.dart';
import 'package:eventapp/common/loading.dart';
import 'package:eventapp/pages/mainPage.dart';
import 'package:eventapp/services/firestore/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:image_picker/image_picker.dart';

class Profiles extends StatefulWidget {
  final User? user;
  const Profiles({Key? key, this.user}) : super(key: key);

  @override
  _ProfilesState createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles> {
  String nom = "";
  String prenom = "";
  String username = "";
  String imageUrl = "";

  bool load = false;
  double? pourcent;

  File? image;
  final key = GlobalKey<FormState>();
  TextEditingController? nomController;
  TextEditingController? usernameController;
  TextEditingController? prenomController;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("users");

  getPhoto(ImageSource source) async {
    XFile? file = await ImagePicker.platform.getImage(source: source);
    if (file != null) {
      setState(() {
        image = File(file.path);
      });
    }
    Navigator.maybePop(context);
  }

  changePhoto() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  getPhoto(ImageSource.camera);
                },
                child: Text("Prendre une photo"),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  getPhoto(ImageSource.gallery);
                },
                child: Text("Choisir une photo"),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Annuler",
              ),
            ),
          );
        });
  }

  getExistingChamp() {
    setState(() {
      load = true;
    });

    collectionReference.doc(widget.user!.uid).get().then((doc) {
      print(doc.data());
      usernameController = TextEditingController(
        text: (doc.data() as dynamic)["username"],
      );
      prenomController = TextEditingController(
        text: (doc.data() as dynamic)["prenom"],
      );
      nomController = TextEditingController(
        text: (doc.data() as dynamic)["nom"],
      );
      setState(() {
        imageUrl = (doc.data() as dynamic)["photoProfile"];
        if (nomController != null &&
            prenomController != null &&
            usernameController != null) {
          nom = nomController!.text;
          prenom = prenomController!.text;
          username = usernameController!.text;
        }
        load = false;
      });
    });
  }

  @override
  void initState() {
    getExistingChamp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return load
        ? Loading(
            pourcent: pourcent,
          )
        : Scaffold(
            backgroundColor: background,
            appBar: AppBar(
              backgroundColor: background,
              title: Text("Profile"),
              elevation: 0,
              centerTitle: true,
              actions: [
                TextButton(
                  onPressed: () async {
                    setState(() {
                      load = true;
                    });
                    if (image != null) {
                      var storage =
                          FirebaseStorage.instance.ref().child(image!.path);
                      UploadTask task = storage.putFile(image!)
                        ..snapshotEvents.listen((event) {
                          setState(() {
                            var source =
                                ((event.bytesTransferred / event.totalBytes) *
                                        100)
                                    .toStringAsPrecision(2);
                            pourcent = double.parse(source);
                          });
                        });
                      imageUrl = await task.then((value) {
                        return value.ref.getDownloadURL();
                      });
                      setState(() {
                        imageUrl;
                      });
                    }

                    DatabaseFirestore(uid: widget.user!.uid).setUser(
                      widget.user!.email!,
                      nom,
                      prenom,
                      username,
                      widget.user!.uid,
                      imageUrl,
                    );
                    setState(() {
                      load = false;
                    });
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return MainPage(user: widget.user);
                      }),
                      (route) => false,
                    );
                  },
                  child: Text("Suivant"),
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Center(
                child: Form(
                  key: key,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      image != null
                          ? Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: lightbackground,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: FileImage(image!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : imageUrl != ""
                              ? Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: lightbackground,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: lightbackground,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      widget.user!.email![0].toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                      SizedBox(height: 5),
                      TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                            Colors.white.withOpacity(0.4),
                          ),
                        ),
                        onPressed: () {
                          changePhoto();
                        },
                        child: Text(
                          "Changer ta photo de profile",
                          style: TextStyle(color: Colors.orange, fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 20),
                      Formulaire(
                        hinText: "nom",
                        onchanged: (n) {
                          setState(() {
                            nom = n;
                          });
                        },
                        controller: nomController,
                      ),
                      SizedBox(height: 20),
                      Formulaire(
                        hinText: "prénom",
                        onchanged: (p) {
                          setState(() {
                            prenom = p;
                          });
                        },
                        controller: prenomController,
                      ),
                      SizedBox(height: 20),
                      Formulaire(
                        hinText: "username",
                        controller: usernameController,
                        onchanged: (u) {
                          setState(() {
                            username = u;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
