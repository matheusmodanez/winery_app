import 'dart:convert';

import 'package:Winery/domain/entities/catalog.dart';
import 'package:sqflite/sqflite.dart';
import 'package:Winery/domain/entities/wine.dart';
import 'package:Winery/resources/databaseManager.dart';

class CatalogRepository {
  late Database db;

  Future<void> initializeClientCatalog(Database db) async {
    final count = await db.rawQuery('SELECT COUNT(*) FROM catalog');
    final int recordsCount = Sqflite.firstIntValue(count) ?? 0;

    if (recordsCount == 0) {
      const catalogId = 001;

      final catalog = Catalog(
        id: catalogId,
        wines: [
          Wine(
            id: 0001,
            name: "Château Margaux",
            origin: "Bordeaux, França",
            grapeType: "Cabernet Sauvignon",
            notes: "Frutas Vermelhas / Violetas / Tabacos / Tanino Suaves",
            idealTemperature: 18.0,
            rpClassification: 4.7,
            clientClassification: 4.2,
            bottle: 'assets/chateau_margaux.png',
            quantity: 1,
          ),
          Wine(
            id: 0002,
            name: "Barolo Piemonte",
            origin: "Piemonte, Itália",
            grapeType: "Nebbiolo",
            notes: "Frutas Vermelhas / Violetas / Taninos Marcados",
            idealTemperature: 18.0,
            rpClassification: 3.8,
            clientClassification: 4,
            bottle: 'assets/barolo-piemont.png',
            quantity: 1,
          ),
          Wine(
            id: 0003,
            name: "Las Beatas",
            origin: "Rioja, Espanha",
            grapeType: "Tempranillo",
            notes: "Frutas Vermelhas / Carvalho / Chocolate / Taninos Marcados",
            idealTemperature: 20.0,
            rpClassification: 4.4,
            clientClassification: 4,
            bottle: 'assets/las_beatas.png',
            quantity: 1,
          ),
          Wine(
            id: 0004,
            name: "Covela",
            origin: "Minho, Portugal",
            grapeType: "Alvarinho",
            notes: "Baunilha / Amêndoa / Carvalho / Taninos Marcados",
            idealTemperature: 18,
            rpClassification: 4.2,
            clientClassification: 3.8,
            bottle: 'assets/covela.png',
            quantity: 1,
          ),
          Wine(
            id: 0005,
            name: "Sancerre",
            origin: "Loire Valley, França",
            grapeType: "Sauvignon Blanc",
            notes: "Cítrico / Floral / Mineral",
            idealTemperature: 10.0,
            rpClassification: 4.2,
            clientClassification: 4.5,
            bottle: 'assets/sancerre.png',
            quantity: 1,
          ),
          Wine(
            id: 0006,
            name: "Brunello di Montalcino",
            origin: "Toscana, Itália",
            grapeType: "Sangiovese",
            notes: "Cereja / Terra / Ervas / Taninos Elegantes",
            idealTemperature: 18.0,
            rpClassification: 4.5,
            clientClassification: 5,
            bottle: 'assets/brunello-di-montalcino.png',
            quantity: 1,
          ),
        ],
      );

      await db.insert(
        'catalog',
        {'id': catalogId, 'winesList': jsonEncode(catalog.toJson()['wines'])},
      );
    }
  }

  Future<void> addWineToCatalog(int catalogId, Wine newWine) async {
    try {
      final catalog = await getCatalog(catalogId);

      if (catalog == null) {
        print('Catalog not found with id: $catalogId');
        return;
      }

      catalog.wines.add(newWine);

      db = await DatabaseManager.instance.database;

      await db.update(
        'catalog',
        {'winesList': json.encode(catalog.toJson()['wines'])},
        where: 'id = ?',
        whereArgs: [catalogId],
      );
    } catch (e) {
      print("Error adding wine to catalog: $e");
    }
  }

  Future<List<Wine>> listWines() async {
    try {
      db = await DatabaseManager.instance.database;

      final List<Map<String, dynamic>> rows = await db.rawQuery('''
    SELECT
     wine.id,
     wine.name,
     wine.origin,
     wine.grapeType,
     wine.notes,
     wine.idealTemperature,
     wine.rpClassification,
     wine.clientClassification,
     wine.bottle,
     wine.quantity
    FROM wine
''');
      return rows
          .map(
            (row) => Wine(
                id: row['id'],
                name: row['name'],
                origin: row['origin'],
                grapeType: row['grapeType'],
                notes: row['notes'],
                idealTemperature: row['idealTemperature'],
                rpClassification: row['rpClassification'],
                clientClassification: row['clientClassification'],
                bottle: row['bottle'],
                quantity: row['quantity']),
          )
          .toList();
    } catch (e) {
      print("Error fetching wines: $e");
      return [];
    }
  }

  Future<int> calculateTotalBottlesInCatalog(Catalog catalog) async {
    try {
      int totalBottles = 0;

      for (var wine in catalog.wines) {
        totalBottles += wine.quantity;
      }

      return totalBottles;
    } catch (e) {
      print("Error calculating total bottles: $e");
      return 0;
    }
  }

  Future<void> updateClientClassification(
      int? id, double newClassification) async {
    if (id == null) {
      print('Error: Wine ID is null');
      return;
    }

    try {
      db = await DatabaseManager.instance.database;

      await db.update(
        'wine',
        {"clientClassification": newClassification},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print("Error updating client classification: $e");
    }
  }

  Future<Catalog> loadProfileCatalog(int? catalogId) async {
    try {
      db = await DatabaseManager.instance.database;

      final List<Map<String, dynamic>> rows = await db.rawQuery('''
      SELECT
      catalog.id,
      catalog.winesList
      FROM catalog
      WHERE catalog.id = ?
      LIMIT 1
    ''', [catalogId]);

      if (rows.isNotEmpty) {
        Map<String, dynamic> row = rows.first;
        List<Wine> winesList = [];

        winesList = List<Wine>.from(
            json.decode(row['winesList']).map((json) => Wine.fromJson(json)));

        return Catalog(
          id: row['id'],
          wines: winesList,
        );
      }
    } catch (e) {
      print("Error fetching profile catalog: $e");
    }
    return Catalog(wines: []);
  }

  Future<void> updateWineQuantity(
      int catalogId, int wineId, int quantity) async {
    final catalog = await getCatalog(catalogId);

    if (catalog == null) {
      print('Catalog not found with id: $catalogId');
      return;
    }

    catalog.wines.forEach((wine) {
      if (wine.id == wineId) {
        wine.quantity = quantity;
      }
    });

    try {
      db = await DatabaseManager.instance.database;

      await db.update(
        'catalog',
        {'winesList': json.encode(catalog.toJson()['wines'])},
        where: 'id = ?',
        whereArgs: [catalogId],
      );
    } catch (e) {
      print("Error updating wine quantity: $e");
    }
  }

  Future<Catalog?> getCatalog(int catalogId) async {
    try {
      db = await DatabaseManager.instance.database;

      final List<Map<String, dynamic>> result = await db.query(
        'catalog',
        where: 'id = ?',
        whereArgs: [catalogId],
      );

      if (result.isNotEmpty) {
        final Map<String, dynamic> catalogMap = result.first;
        final List<dynamic> winesJson = json.decode(catalogMap['winesList']);

        final List<Wine> wines =
            winesJson.map((wineJson) => Wine.fromJson(wineJson)).toList();

        return Catalog(id: catalogId, wines: wines);
      }
    } catch (e) {
      print("Error fetching catalog: $e");
    }

    return null;
  }
}
