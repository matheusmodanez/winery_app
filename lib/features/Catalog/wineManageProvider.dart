import 'package:flutter/material.dart';
import '../../domain/entities/wine.dart';

class WineManageProvider extends ChangeNotifier {
  List<Wine> _lastAccessedWines = [];

  List<Wine> get lastAccessedWines => _lastAccessedWines;

  void addLastAccessedWine(Wine wine) {
    _lastAccessedWines.insert(0, wine);
    if (_lastAccessedWines.length > 3) {
      _lastAccessedWines.removeLast();
    }
    notifyListeners();
  }
}
