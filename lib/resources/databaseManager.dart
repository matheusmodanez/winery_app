import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  DatabaseManager._init();

  static final DatabaseManager instance = DatabaseManager._init();
  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), 'winery.db'),
        version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute(_wine);
    await db.execute(_catalog);
    await db.execute(_profile);
  }

  String get _wine => '''
    CREATE TABLE IF NOT EXISTS wine (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      origin TEXT,
      grapeType TEXT,
      notes TEXT,
      idealTemperature DOUBLE,
      rpClassification DOUBLE,
      clientClassification DOUBLE,
      bottle TEXT,
      quantity INTEGER
    );
  ''';

  String get _catalog => '''
    CREATE TABLE IF NOT EXISTS catalog (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      winesList TEXT
    );
  ''';

  String get _profile => '''
    CREATE TABLE IF NOT EXISTS profile (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT, 
      profilePicture TEXT, 
      serviceType TEXT, 
      wineryCapacity INTEGER, 
      catalogId INTEGER
    );
  ''';
}
