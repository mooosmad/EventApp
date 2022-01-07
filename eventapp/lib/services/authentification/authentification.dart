// ignore_for_file: prefer_if_null_operators, avoid_print, prefer_const_constructors

import 'package:eventapp/pages/mainPage.dart';
import 'package:eventapp/services/firestore/firestore.dart';
import 'package:eventapp/services/wrapper/profilesWrapper.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Authentification {
  FirebaseAuth auth = FirebaseAuth.instance;

  User? utilisateur(User? user) {
    return user != null ? user : null;
  }

  Stream<User?> get user {
    return auth.authStateChanges().map(utilisateur);
  }

  Future createUser(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      DatabaseFirestore(uid: user!.uid).setUser(
        email,
        "",
        "",
        "",
        user.uid,
        "",
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) {
          return ProfileWrapper(user: user);
        }),
        (route) => false,
      );
      return utilisateur(user);
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: e.toString(),
      );
      return null;
    }
  }

  Future signIn(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) {
          return MainPage(user: user);
        }),
        (route) => false,
      ); // supprime tt les pages anciennes et passe à autre pages

      return utilisateur(user);
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: e.toString(),
      );
      return null;
    }
  }

  Future signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
