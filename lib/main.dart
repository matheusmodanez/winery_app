import 'package:flutter/material.dart';
import 'package:winery_app/features/Catalog/catalogPage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:winery_app/features/Catalog/catalogRepository.dart';
import 'package:winery_app/features/Catalog/winePage.dart';
import 'package:winery_app/resources/databaseManager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Database db = await DatabaseManager.instance.database;

  final repository = CatalogRepository();

  await repository.insertInitialWines(db);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Winery',
      debugShowCheckedModeBanner: false,
      // theme: lightTheme,
      routes: {
        '/': (context) => const CatalogPage(),
        '/wineDetails': (context) => WineDetailsPage(),
      },
      initialRoute: '/',
    );
  }
}
