import 'package:Winery/domain/entities/profile.dart';
import 'package:Winery/resources/databaseManager.dart';
import 'package:sqflite/sqflite.dart';

class ProfileRepository {
  late Database db;

  Future<void> initialProfiles(Database db) async {
    final count = await db.rawQuery('SELECT COUNT(*) FROM profile');
    final int recordsCount = Sqflite.firstIntValue(count) ?? 0;

    if (recordsCount == 0) {
      await db.insert("profile", {
        "id": 0001,
        "name": "Luigi",
        "profilePicture": 'assets/papa.png',
        "serviceType": 'premium',
        "wineryCapacity": '6',
        "quantity": '6'
      });
    }
  }

  Future<Profile> loadProfile(int id) async {
    try {
      db = await DatabaseManager.instance.database;

      final List<Map<String, dynamic>> rows = await db.rawQuery('''
            SELECT
            profile.id,
            profile.name,
            profile.profilePicture,
            profile.serviceType,
            profile.wineryCapacity,
            profile.quantity
            FROM profile
            WHERE profile.id = ?
            LIMIT 1
        ''', [id]);
      if (rows.isNotEmpty) {
        Map<String, dynamic> row = rows.first;
        return Profile(
          id: row['id'],
          name: row['name'],
          profilePicture: row['profilePicture'],
          serviceType: row['serviceType'],
          wineryCapacity: row['wineryCapacity'],
          quantity: row['quantity'],
        );
      }
    } catch (e) {
      print("Error fetching wines: $e");
      return Profile(
          name: '',
          profilePicture: '',
          serviceType: '',
          wineryCapacity: 0,
          quantity: 0);
    }
    return Profile(
        name: '',
        profilePicture: '',
        serviceType: '',
        wineryCapacity: 0,
        quantity: 0);
  }
}
