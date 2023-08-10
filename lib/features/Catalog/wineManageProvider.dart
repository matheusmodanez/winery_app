import 'dart:convert';

import 'package:flutter/material.dart';
import '../../domain/entities/wine.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WineManageProvider extends ChangeNotifier {
  List<Wine> _lastAccessedWines = [];

  List<Wine> get lastAccessedWines => _lastAccessedWines;

  Future<void> loadLastAccessedWines() async {
    final prefs = await SharedPreferences.getInstance();
    final winesJson = prefs.getString('lastAccessedWines');

    if (winesJson != null) {
      final List<dynamic> decodedJson = jsonDecode(winesJson);
      _lastAccessedWines =
          decodedJson.map((json) => Wine.fromJson(json)).toList();
      notifyListeners();
    }
  }

  void addLastAccessedWine(Wine wine) async {
    final existingIndex = _lastAccessedWines.indexWhere((w) => w.id == wine.id);

    if (existingIndex != -1) {
      _lastAccessedWines.removeAt(existingIndex);
    }

    _lastAccessedWines.insert(0, wine);

    if (_lastAccessedWines.length > 3) {
      _lastAccessedWines.removeLast();
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastAccessedWines',
        jsonEncode(_lastAccessedWines.map((wine) => wine.toJson()).toList()));

    notifyListeners();
  }

  void updateWineRating(int wineId, double newRating) async {
    final wineIndex = _lastAccessedWines.indexWhere((w) => w.id == wineId);
    if (wineIndex != -1) {
      _lastAccessedWines[wineIndex].clientClassification = newRating;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('wineRating ',
          jsonEncode(_lastAccessedWines.map((wine) => wine.toJson()).toList()));
      notifyListeners();
    }
  }
}
