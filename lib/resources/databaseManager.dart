import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  Future<Database> getDatabase() async {
    final path = join(await getDatabasesPath(), 'winery.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute(_wine);
    await db.insert("wine", {
      "name": "Château Margaux",
      "origin": "Bordeaux, França",
      "notes": "Frutas Vermelhas / Violetas / Tabacos / Tanino Suaves",
      "idealTemperature": 18.0,
      "rpClassification": 4,
      "clientClassification": 3.5
    });
  }

  String get _wine => '''
    CREATE TABLE IF NOT EXISTS wine (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      origin TEXT,
      notes TEXT,
      idealTemperature DOUBLE,
      rpClassification DOUBLE,
      clientClassification DOUBLE
    );
  ''';
}
