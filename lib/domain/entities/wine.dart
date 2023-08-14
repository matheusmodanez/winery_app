class Wine {
  int? id;
  String name;
  String origin;
  String grapeType;
  String notes;
  double idealTemperature;
  double? rpClassification;
  double clientClassification;
  String bottle;
  int quantity;

  Wine(
      {this.id,
      required this.name,
      required this.origin,
      required this.grapeType,
      required this.notes,
      required this.idealTemperature,
      this.rpClassification,
      required this.clientClassification,
      required this.bottle,
      required this.quantity});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'origin': origin,
      'grapeType': grapeType,
      'notes': notes,
      'idealTemperature': idealTemperature,
      'rpClassification': rpClassification,
      'clientClassification': clientClassification,
      'bottle': bottle,
      'quantity': quantity,
    };
  }

  factory Wine.fromJson(Map<String, dynamic> json) {
    return Wine(
      id: json['id'],
      name: json['name'],
      origin: json['origin'],
      grapeType: json['grapeType'],
      notes: json['notes'],
      idealTemperature: json['idealTemperature'],
      rpClassification: json['rpClassification'],
      clientClassification: json['clientClassification'],
      bottle: json['bottle'],
      quantity: json['quantity'],
    );
  }
}
