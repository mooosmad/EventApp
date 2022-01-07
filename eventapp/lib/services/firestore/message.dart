class Message {
  String? content;
  String? datetime;
  String? uidEnvoyeur;

  Message({this.content, this.datetime, this.uidEnvoyeur});

  Map<String, dynamic> toMap() {
    return {
      "content": content,
      "datetime": datetime,
      "uidEnvoyeur": uidEnvoyeur,
    };
  }
}
