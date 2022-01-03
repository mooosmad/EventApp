class Evenement {
  String? dateDebut;
  String? dateFin;
  String? nom;
  String? description;
  String? urlDescription;
  String? color;
  String? dateCreation;
  Evenement({
    this.dateDebut,
    this.description,
    this.nom,
    this.urlDescription,
    this.dateFin,
    this.color,
    this.dateCreation,
  });

  Map<String, dynamic> toMap() {
    return {
      "date debut": dateDebut,
      "date fin": dateFin,
      "nomEvenement": nom,
      "description": description,
      "urlDescription": urlDescription,
      "color": color,
      "date de creation": dateCreation
    };
  }
  // factory  fromMap
}
