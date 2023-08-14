import 'package:Winery/domain/entities/wine.dart';
import 'package:flutter/material.dart';
import 'package:Winery/domain/entities/catalog.dart';

class CatalogProvider extends ChangeNotifier {
  Catalog _catalog;
  int _totalBottles;

  CatalogProvider(this._catalog, this._totalBottles);

  Catalog get catalog => _catalog;
  int get totalBottles => _totalBottles;

  void updateWineQuantity(int wineId, int quantity) {
    _catalog.wines.forEach((wine) {
      if (wine.id == wineId) {
        wine.quantity = quantity;
      }
    });
    _calculateTotalBottles();

    notifyListeners();
  }

  void loadCatalog(Catalog catalog) {
    _catalog = catalog;
    notifyListeners();
  }

  void _calculateTotalBottles() {
    _totalBottles =
        _catalog.wines.fold<int>(0, (sum, wine) => sum + wine.quantity);
  }

  void addWine(Wine newWine) {
    _catalog.wines.add(newWine);
    notifyListeners();
  }
}
