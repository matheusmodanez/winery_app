import 'package:Winery/domain/entities/wine.dart';

class Catalog {
  int? id;
  List<Wine> wines;

  Catalog({this.id, required this.wines});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'wines': wines.map((wine) => wine.toJson()).toList(),
    };
  }

  factory Catalog.fromJson(Map<String, dynamic> json) {
    return Catalog(
      id: json['id'],
      wines: (json['wines'] as List<dynamic>)
          .map((wineJson) => Wine.fromJson(wineJson))
          .toList(),
    );
  }
}
