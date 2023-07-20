class Wine {
  String? id;
  String name;
  String origin;
  String notes;
  double idealTemperature;
  double rpClassification;
  double clientClassification;

  Wine(
      {this.id,
      required this.name,
      required this.origin,
      required this.notes,
      required this.idealTemperature,
      required this.rpClassification,
      required this.clientClassification});
}
