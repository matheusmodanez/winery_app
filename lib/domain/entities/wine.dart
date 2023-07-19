class Wine {
  String? id;
  String name;
  String origin;
  List<String> notes;
  int idealTemperature;
  int rpClassification;
  int clientClassification;

  Wine(
      {this.id,
      required this.name,
      required this.origin,
      required this.notes,
      required this.idealTemperature,
      required this.rpClassification,
      required this.clientClassification});
}
