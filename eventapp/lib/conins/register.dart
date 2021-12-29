// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:eventapp/common/constant.dart';
import 'package:eventapp/common/formulaire.dart';
import 'package:eventapp/common/loading.dart';
import 'package:eventapp/conins/login.dart';
import 'package:eventapp/services/authentification/authentification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = "";
  String password = "";
  bool load = false;
  String retapePassword = "";
  final key = GlobalKey<FormState>();
  Authentification authentification = Authentification();
  @override
  Widget build(BuildContext context) {
    return load
        ? Loading()
        : Scaffold(
            backgroundColor: background,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: background,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Form(
                  key: key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Inscrivez-vous.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Bienvenue à vous",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        "Event App pour vous servir!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 30),
                      Formulaire(
                        hinText: "email",
                        validator: (e) {
                          if (e!.isEmpty) {
                            return "email vide";
                          }
                        },
                        onchanged: (e) {
                          setState(() {
                            email = e;
                          });
                          print(email);
                        },
                      ),
                      SizedBox(height: 15),
                      Formulaire(
                        hinText: "mot de passe",
                        validator: (e) {
                          if (e!.isEmpty) {
                            return "mot de passe vide";
                          } else if (e.length < 6) {
                            return "mot de passe trop court";
                          }
                        },
                        icon: Icons.lock,
                        onchanged: (p) {
                          setState(() {
                            password = p;
                          });
                          print(password);
                        },
                      ),
                      SizedBox(height: 15),
                      Formulaire(
                        hinText: "repetez le mot de passe",
                        validator: (e) {
                          if (retapePassword != password) {
                            return "les 02 mots de passe sont différents";
                          }
                        },
                        icon: Icons.lock,
                        onchanged: (np) {
                          setState(() {
                            retapePassword = np;
                          });
                          print(retapePassword);
                        },
                      ),
                      SizedBox(height: 50),
                      RichText(
                        text: TextSpan(
                            text: "Vous avez déja un compte?   ",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                      context,
                                      CupertinoPageRoute(builder: (context) {
                                        return Login();
                                      }),
                                    );
                                  },
                                text: "Se connecter",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () async {
                          if (key.currentState!.validate()) {
                            setState(() {
                              load = true;
                            });
                            var result = await authentification.createUser(
                                email, password, context);
                            if (result == null) {
                              setState(() {
                                load = false;
                              });
                            }
                          } else {
                            print("no completed");
                          }
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(15),
                          ),
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
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
