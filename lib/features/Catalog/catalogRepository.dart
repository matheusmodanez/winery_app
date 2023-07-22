import 'package:sqflite/sqflite.dart';
import 'package:Winery/domain/entities/wine.dart';
import 'package:Winery/resources/databaseManager.dart';

class CatalogRepository {
  late Database db;

  Future<void> insertInitialWines(Database db) async {
    final count = await db.rawQuery('SELECT COUNT(*) FROM wine');
    final int recordsCount = Sqflite.firstIntValue(count) ?? 0;

    if (recordsCount == 0) {
      await db.insert("wine", {
        "id": 0001,
        "name": "Château Margaux",
        "origin": "Bordeaux, França",
        "grapeType": "Cabernet Sauvignon",
        "notes": "Frutas Vermelhas / Violetas / Tabacos / Tanino Suaves",
        "idealTemperature": 18.0,
        "rpClassification": 4.7,
        "clientClassification": 4.2,
        "bottle": 'assets/chateau_margaux.png',
      });

      await db.insert("wine", {
        "id": 0002,
        "name": "Barolo Piemonte",
        "origin": "Piemonte, Itália",
        "grapeType": "Nebbiolo",
        "notes": "Frutas Vermelhas / Violetas / Taninos Marcados",
        "idealTemperature": 18.0,
        "rpClassification": 3.8,
        "clientClassification": 4,
        "bottle": 'assets/barolo-piemont.png',
      });

      await db.insert("wine", {
        "id": 0003,
        "name": "Las Beatas",
        "origin": "Rioja, Espanha",
        "grapeType": "Tempranillo",
        "notes": "Frutas Vermelhas / Carvalho / Chocolate / Taninos Marcados",
        "idealTemperature": 20.0,
        "rpClassification": 4.4,
        "clientClassification": 4,
        "bottle": 'assets/las_beatas.png',
      });

      await db.insert("wine", {
        "id": 0004,
        "name": "Covela",
        "origin": "Minho, Portugal",
        "grapeType": "Alvarinho",
        "notes": "Baunilha / Amêndoa / Carvalho / Taninos Marcados",
        "idealTemperature": 18,
        "rpClassification": 4.2,
        "clientClassification": 3.8,
        "bottle": 'assets/covela.png',
      });
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
     wine.bottle
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
            ),
          )
          .toList();
    } catch (e) {
      print("Error fetching wines: $e");
      return []; // Return an empty list to avoid rendering errors.
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
}
