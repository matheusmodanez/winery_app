import 'package:sqflite/sqflite.dart';
import 'package:winery_app/domain/entities/wine.dart';
import 'package:winery_app/resources/databaseManager.dart';

class CatalogRepository {
  late Database db;

  Future<void> insertInitialWines(Database db) async {
    await db.insert("wine", {
      "name": "Château Margaux",
      "origin": "Bordeaux, França",
      "notes": "Frutas Vermelhas / Violetas / Tabacos / Tanino Suaves",
      "idealTemperature": 18.0,
      "rpClassification": 4,
      "clientClassification": 3.5,
    });

    await db.insert("wine", {
      "name": "Barolo Piemonte",
      "origin": "Piemonte, Itália",
      "notes": "Frutas Vermelhas / Violetas / Taninos Marcados",
      "idealTemperature": 18.0,
      "rpClassification": 3.8,
      "clientClassification": 4,
    });
  }

  Future<List<Wine>> listWines() async {
    try {
      db = await DatabaseManager.instance.database;

      final List<Map<String, dynamic>> rows = await db.rawQuery('''
    SELECT
     wine.id,
     wine.name,
     wine.origin,
     wine.notes,
     wine.idealTemperature,
     wine.rpClassification,
     wine.clientClassification
    FROM wine
''');
      return rows
          .map(
            (row) => Wine(
                name: row['name'],
                origin: row['origin'],
                notes: row['notes'],
                idealTemperature: row['idealTemperature'],
                rpClassification: row['rpClassification'],
                clientClassification: row['clientClassification']),
          )
          .toList();
    } catch (e) {
      print("Error fetching wines: $e");
      return []; // Return an empty list to avoid rendering errors.
    }
  }
}
