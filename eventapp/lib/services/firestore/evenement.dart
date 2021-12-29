class Evenement {
  // DateTime? dateDebut;
  // DateTime? dateFin;
  String? nom;
  String? description;
  String? urlDescription;
  Evenement({
    // this.dateDebut,
    this.description,
    this.nom,
    this.urlDescription,
    // this.dateFin,
  });

  Map<String, dynamic> toMap() {
    return {
      // "date debut": dateDebut,
      // "date fin": dateFin,
      "nomEvenement": nom,
      "description": description,
      "urlDescription": urlDescription,
    };
  }
  // factory  fromMap
}
