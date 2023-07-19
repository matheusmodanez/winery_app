import 'package:winery_app/domain/entities/wine.dart';
import 'package:winery_app/resources/databaseManager.dart';

class CatalogRepository {
  Future<List<Wine>> listWines() async {
    final db = await DatabaseManager().getDatabase();

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
  }
}
