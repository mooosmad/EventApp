// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:eventapp/common/constant.dart';
import 'package:eventapp/common/formulaire.dart';
import 'package:eventapp/common/loading.dart';
import 'package:eventapp/conins/register.dart';
import 'package:eventapp/services/authentification/authentification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "";
  String password = "";
  bool load = false;
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
                        "Connectez-vous.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "content de te revoir",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        "Vous nous avez manquez!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 30),
                      Formulaire(
                        validator: (e) {
                          if (e!.isEmpty) {
                            return "email vide";
                          }
                        },
                        hinText: "email",
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
                      SizedBox(height: 50),
                      RichText(
                        text: TextSpan(
                            text: "Vous n'avez pas de compte?   ",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                      context,
                                      CupertinoPageRoute(builder: (context) {
                                        return Register();
                                      }),
                                    );
                                  },
                                text: "S'inscrire",
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
                            var result = await authentification.signIn(
                                email, password, context);
                            if (result == null) {
                              setState(() {
                                load = false;
                              });
                            }
                          } else {
                            print("no compketed");
                          }
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: lightbackground,
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
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
