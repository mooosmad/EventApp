// ignore_for_file: file_names

import "package:cloud_firestore/cloud_firestore.dart";
import 'package:eventapp/services/firestore/evenement.dart';
import 'package:eventapp/services/firestore/message.dart';

class GestionEvent {
  final String? uid;

  GestionEvent({this.uid});
  CollectionReference eventCollection =
      FirebaseFirestore.instance.collection("Evenements");

  addEvent(Evenement evenement,String docName) {
    eventCollection
        .doc(uid)
        .collection("MesEvenements")
        .doc(
          docName
        )
        .set(
          evenement.toMap(),
        );
  }

  messageEvent(Message message, String docName) {
    DocumentReference documentReference = eventCollection
        .doc(uid)
        .collection("MesEvenements")
        .doc(docName)
        .collection("Messages")
        .doc(
          DateTime.now().millisecondsSinceEpoch.toString(),
        );
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        message.toMap(),
      );
    });
  }

  List<Evenement> listEvent(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return Evenement(
        dateDebut: (doc.data() as dynamic)["date debut"],
        dateFin: (doc.data() as dynamic)["date fin"],
        description: (doc.data() as dynamic)["description"],
        nom: (doc.data() as dynamic)["nomEvenement"],
        urlDescription: (doc.data() as dynamic)["urlDescription"],
        color: (doc.data() as dynamic)["color"],
        dateCreation: (doc.data() as dynamic)["date de creation"],
      );
    }).toList();
  }

  Stream<List<Evenement>> getAllMyEvents() {
    return eventCollection
        .doc(uid)
        .collection("MesEvenements")
        .orderBy("date de creation", descending: true)
        .snapshots()
        .map(listEvent);
  }
}
