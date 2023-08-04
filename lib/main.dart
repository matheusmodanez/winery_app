import 'package:Winery/features/3DModels/winery3D.dart';
import 'package:Winery/features/Catalog/wineManageProvider.dart';
import 'package:Winery/features/Management/managementPage.dart';
import 'package:Winery/features/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:Winery/features/Catalog/catalogPage.dart';
import 'package:Winery/features/Catalog/catalogRepository.dart';
import 'package:Winery/features/Catalog/winePage.dart';
import 'package:Winery/resources/databaseManager.dart';

import 'domain/entities/wine.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Database db = await DatabaseManager.instance.database;

  final repository = CatalogRepository();

  await repository.insertInitialWines(db);

  runApp(
    ChangeNotifierProvider(
      create: (context) => WineManageProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Winery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'MuseoModerno',
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => IntroPage(),
        '/': (context) => const CatalogPage(),
        '/wineryModel': (context) => const WineryModel(),
        '/management': (context) => const ManagementPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/wineDetails') {
          final wine = settings.arguments as Wine;
          return MaterialPageRoute(
            builder: (context) => WineDetailsPage(wine: wine),
          );
        }
        return null;
      },
    );
  }
}
