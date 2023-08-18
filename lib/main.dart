import 'package:Winery/features/3DModels/winery3D.dart';
import 'package:Winery/features/catalog/catalogProvider.dart';
import 'package:Winery/features/management/catalogManagementPage.dart';
import 'package:Winery/features/management/managementPage.dart';
import 'package:Winery/features/profile/profileRepository.dart';
import 'package:Winery/features/loginPage.dart';
import 'package:Winery/features/wine/newWine.dart';
import 'package:Winery/features/wine/wineManageProvider.dart';
import 'package:Winery/features/wine/winePage.dart';
import 'package:Winery/features/wine/wineryCatalogPage.dart';
import 'package:Winery/shared/utils/countryUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:Winery/features/catalog/catalogPage.dart';
import 'package:Winery/features/catalog/catalogRepository.dart';
import 'package:Winery/resources/databaseManager.dart';

import 'domain/entities/wine.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Database db = await DatabaseManager.instance.database;

  final catalogRepository = CatalogRepository();
  await catalogRepository.initializeWineryCatalog(db);
  await catalogRepository.initializeClientCatalog(db);

  final profileRepository = ProfileRepository();
  await profileRepository.initialProfiles(db);

  final wineManagerProvider = WineManageProvider();
  wineManagerProvider.loadLastAccessedWines();

  final wineryCatalog = await catalogRepository.loadProfileCatalog(00001);
  final catalog = await catalogRepository.loadProfileCatalog(00002);

  final List<Wine> filteredWines = catalog.wines;
  final List<String> availableTags = CountryUtils.countries;

  final totalBottles =
      await catalogRepository.calculateTotalBottlesInCatalog(catalog);
  final catalogProvider = CatalogProvider(
      wineryCatalog, catalog, totalBottles, filteredWines, availableTags);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => wineManagerProvider),
        ChangeNotifierProvider(create: (context) => catalogProvider),
      ],
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
        '/catalogManagement': (context) => const CatalogManagementPage(),
        '/wineryCatalog': (context) => const WineryCatalogPage(),
        '/newWine': (context) => NewWine(),
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
