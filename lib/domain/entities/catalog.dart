import 'package:winery_app/domain/entities/wine.dart';

class Catalog {
  String? id;
  List<Wine> wines;

  Catalog({this.id, required this.wines});
}