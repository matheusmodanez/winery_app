import 'package:Winery/domain/entities/wine.dart';
import 'package:Winery/shared/utils/countryUtils.dart';
import 'package:flutter/material.dart';
import 'package:Winery/domain/entities/catalog.dart';

class CatalogProvider extends ChangeNotifier {
  Catalog _wineryCatalog;
  Catalog _catalog;
  int _totalBottles;
  List<Wine> _filteredWines;
  List<String> _availableTags = [];

  void applyFilter(String tag) {
    final filteredWines = tag == 'Todas'
        ? _catalog.wines
        : _catalog.wines.where((wine) => wine.origin.contains(tag)).toList();

    final wineOrigins = filteredWines
        .map((wine) => wine.origin.split(',').last.trim().toLowerCase())
        .toSet();

    _filteredWines = filteredWines;
    _availableTags = CountryUtils.countries
        .where((country) =>
            wineOrigins.any((origin) => origin.contains(country.toLowerCase())))
        .toList();

    notifyListeners();
  }

  CatalogProvider(this._wineryCatalog, this._catalog, this._totalBottles,
      this._filteredWines, this._availableTags);

  Catalog get wineryCatalog => _wineryCatalog;
  Catalog get catalog => _catalog;
  int get totalBottles => _totalBottles;
  List<Wine> get filteredWines => _filteredWines;
  List<String> get availableTags => _availableTags;

  void updateWineQuantity(int wineId, int quantity) {
    _catalog.wines.forEach((wine) {
      if (wine.id == wineId) {
        wine.quantity = quantity;
      }
    });
    calculateTotalBottles();

    notifyListeners();
  }

  void calculateTotalBottles() {
    _totalBottles =
        _catalog.wines.fold<int>(0, (sum, wine) => sum + wine.quantity);
  }

  void addWine(Wine newWine) {
    _catalog.wines.add(newWine);
    notifyListeners();
  }

  void removeWine(int wineId) {
    _catalog.wines.removeWhere((wine) => wine.id == wineId);
    notifyListeners();
  }
}
