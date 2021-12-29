import "package:cloud_firestore/cloud_firestore.dart";

class DatabaseFirestore {
  final String? uid;
  DatabaseFirestore({this.uid});
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  setUser(String email, String nom, String prenom, String username, String uid,
      String photoProfile) {
    userCollection.doc(uid).set({
      "email": email,
      "nom": nom,
      "prenom": prenom,
      "username": username,
      "uid": uid,
      "photoProfile": photoProfile,
    });
  }
}
