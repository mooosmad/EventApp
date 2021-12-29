class Evenement {
  String? dateDebut;
  String? dateFin;
  String? nom;
  String? description;
  String? urlDescription;
  String? color;
  Evenement({
    this.dateDebut,
    this.description,
    this.nom,
    this.urlDescription,
    this.dateFin,
    this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      "date debut": dateDebut,
      "date fin": dateFin,
      "nomEvenement": nom,
      "description": description,
      "urlDescription": urlDescription,
      "color": color,
    };
  }
  // factory  fromMap
}
