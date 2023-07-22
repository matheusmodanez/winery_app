class Wine {
  String? id;
  String name;
  String origin;
  String grapeType;
  String notes;
  double idealTemperature;
  double rpClassification;
  double clientClassification;
  String bottle;

  Wine(
      {this.id,
      required this.name,
      required this.origin,
      required this.grapeType,
      required this.notes,
      required this.idealTemperature,
      required this.rpClassification,
      required this.clientClassification,
      required this.bottle});
}
