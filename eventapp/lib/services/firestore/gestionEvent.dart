// ignore_for_file: file_names

import "package:cloud_firestore/cloud_firestore.dart";
import 'package:eventapp/services/firestore/evenement.dart';

class GestionEvent {
  final String? uid;

  GestionEvent({this.uid});
  CollectionReference eventCollection =
      FirebaseFirestore.instance.collection("evenements");

  addEvent(Evenement evenement) {
    eventCollection
        .doc(uid)
        .collection("mesevenements")
        .doc(
          DateTime.now().millisecondsSinceEpoch.toString(),
        )
        .set(
          evenement.toMap(),
        );
  }

  List<Evenement> listEvent(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return Evenement(
        // dateDebut: (doc.data() as dynamic)["date debut"],
        // dateFin: (doc.data() as dynamic)["date fin"],
        description: (doc.data() as dynamic)["description"],
        nom: (doc.data() as dynamic)["nomEvenement"],
        urlDescription: (doc.data() as dynamic)["urlDescription"],
      );
    }).toList();
  }

  Stream<List<Evenement>> getAllMyEvents() {
    return eventCollection
        .doc(uid)
        .collection("mesevenements")
        .snapshots()
        .map(listEvent);
  }
}
