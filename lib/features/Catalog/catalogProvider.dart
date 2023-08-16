import 'package:Winery/domain/entities/wine.dart';
import 'package:flutter/material.dart';
import 'package:Winery/domain/entities/catalog.dart';

class CatalogProvider extends ChangeNotifier {
  Catalog _wineryCatalog;
  Catalog _catalog;
  int _totalBottles;

  CatalogProvider(this._wineryCatalog, this._catalog, this._totalBottles);

  Catalog get catalog => _catalog;
  Catalog get wineryCatalog => _wineryCatalog;
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

  void _calculateTotalBottles() {
    _totalBottles =
        _catalog.wines.fold<int>(0, (sum, wine) => sum + wine.quantity);
  }

  void addWine(Wine newWine) {
    _catalog.wines.add(newWine);
    notifyListeners();
  }
}
