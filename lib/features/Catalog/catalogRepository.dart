import 'dart:convert';

import 'package:Winery/domain/entities/catalog.dart';
import 'package:sqflite/sqflite.dart';
import 'package:Winery/domain/entities/wine.dart';
import 'package:Winery/resources/databaseManager.dart';

class CatalogRepository {
  late Database db;

  Future<void> initializeWineryCatalog(Database db) async {
    final count = await db.rawQuery('SELECT COUNT(*) FROM catalog');
    final int recordsCount = Sqflite.firstIntValue(count) ?? 0;

    if (recordsCount == 0) {
      const catalogId = 00001;

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
            rpClassification: 0,
            clientClassification: 0,
            bottle: 'assets/bottles/chateau_margaux.png',
            quantity: 0,
          ),
          Wine(
            id: 0002,
            name: "Barolo Piemonte",
            origin: "Piemonte, Itália",
            grapeType: "Nebbiolo",
            notes: "Frutas Vermelhas / Violetas / Taninos Marcados",
            idealTemperature: 18.0,
            rpClassification: 0,
            clientClassification: 0,
            bottle: 'assets/bottles/barolo-piemont.png',
            quantity: 0,
          ),
          Wine(
            id: 0003,
            name: "Las Beatas",
            origin: "Rioja, Espanha",
            grapeType: "Tempranillo",
            notes: "Frutas Vermelhas / Carvalho / Chocolate / Taninos Marcados",
            idealTemperature: 20.0,
            rpClassification: 0,
            clientClassification: 0,
            bottle: 'assets/bottles/las_beatas.png',
            quantity: 0,
          ),
          Wine(
            id: 0004,
            name: "Covela",
            origin: "Minho, Portugal",
            grapeType: "Alvarinho",
            notes: "Baunilha / Amêndoa / Carvalho / Taninos Marcados",
            idealTemperature: 18,
            rpClassification: 0,
            clientClassification: 0,
            bottle: 'assets/bottles/covela.png',
            quantity: 0,
          ),
          Wine(
            id: 0005,
            name: "Sancerre",
            origin: "Loire Valley, França",
            grapeType: "Sauvignon Blanc",
            notes: "Cítrico / Floral / Mineral",
            idealTemperature: 10.0,
            rpClassification: 0,
            clientClassification: 0,
            bottle: 'assets/bottles/sancerre.png',
            quantity: 0,
          ),
          Wine(
            id: 0006,
            name: "Brunello di Montalcino",
            origin: "Toscana, Itália",
            grapeType: "Sangiovese",
            notes: "Cereja / Terra / Ervas / Taninos Elegantes",
            idealTemperature: 18.0,
            rpClassification: 0,
            clientClassification: 0,
            bottle: 'assets/bottles/brunello-di-montalcino.png',
            quantity: 0,
          ),
          Wine(
            id: 0007,
            name: "Château Lafite Rothschild",
            origin: "Bordeaux, França",
            grapeType: "Cabernet Sauvignon",
            notes: "Cassis / Cedro / Tabaco",
            idealTemperature: 18.0,
            rpClassification: 0,
            clientClassification: 0,
            bottle: 'assets/bottles/chateau_latife_rothschild.png',
            quantity: 0,
          ),
          Wine(
              id: 0008,
              name: "Opus One",
              origin: "Napa Valley, EUA",
              grapeType: "Cabernet Sauvignon",
              notes: "Cereja Preta / Baunilha / Café",
              idealTemperature: 19.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: 'assets/bottles/opus_one.png',
              quantity: 0),
          Wine(
              id: 0009,
              name: "Barolo Monfortino",
              origin: "Piemonte, Itália",
              grapeType: "Nebbiolo",
              notes: "Cereja / Rosa / Alcatrão",
              idealTemperature: 17.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: 'assets/bottles/barolo_monfortino.png',
              quantity: 0),
          Wine(
              id: 0010,
              name: "Rioja Alta Gran Reserva 904",
              origin: "Rioja, Espanha",
              grapeType: "Tempranillo",
              notes: "Cereja Madura / Couro / Baunilha",
              idealTemperature: 17.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: 'assets/bottles/rioja_alta_gran_reserva_904.png',
              quantity: 0),
          Wine(
              id: 0011,
              name: "Penfolds Grange",
              origin: "South Australia",
              grapeType: "Shiraz",
              notes: "Amora Preta / Chocolate / Pimenta",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: 'assets/bottles/penfold_grange.png',
              quantity: 0),
          Wine(
              id: 0012,
              name: "Sassicaia",
              origin: "Toscana, Itália",
              grapeType: "Cabernet Sauvignon",
              notes: "Cassis / Eucalipto / Baunilha",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: 'assets/bottles/sassicaia.png',
              quantity: 0),
          Wine(
              id: 0013,
              name: "Château d'Yquem",
              origin: "Bordeaux, França",
              grapeType: "Sémillon",
              notes: "Mel / Damasco / Baunilha",
              idealTemperature: 12.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: 'assets/bottles/chateau_dyquem.png',
              quantity: 0),
          Wine(
              id: 0014,
              name: "Dom Pérignon",
              origin: "Champagne, França",
              grapeType: "Chardonnay / Pinot Noir",
              notes: "Maçã Verde / Amêndoa / Brioche",
              idealTemperature: 8.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: 'assets/bottles/dom_perignon.png',
              quantity: 0),
          Wine(
              id: 0015,
              name: "Almaviva",
              origin: "Maipo Valley, Chile",
              grapeType: "Cabernet Sauvignon",
              notes: "Cassis / Cereja / Pimenta",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: 'assets/bottles/almaviva.png',
              quantity: 0),
          Wine(
              id: 0016,
              name: "Château Palmer",
              origin: "Bordeaux, França",
              grapeType: "Merlot / Cabernet Sauvignon",
              notes: "Cassis / Violeta / Tabaco",
              idealTemperature: 17.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0017,
              name: "Château Mouton Rothschild",
              origin: "Bordeaux, França",
              grapeType: "Cabernet Sauvignon",
              notes: "Cassis / Pimenta / Cedro",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0018,
              name: "Tignanello",
              origin: "Toscana, Itália",
              grapeType: "Sangiovese / Cabernet Sauvignon",
              notes: "Cereja / Ervas / Baunilha",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0019,
              name: "Caymus Special Selection",
              origin: "Napa Valley, EUA",
              grapeType: "Cabernet Sauvignon",
              notes: "Cassis / Chocolate / Canela",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0020,
              name: "Château Margaux Pavillon Rouge",
              origin: "Bordeaux, França",
              grapeType: "Cabernet Sauvignon / Merlot",
              notes: "Cassis / Violeta / Couro",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0021,
              name: "Solaia",
              origin: "Toscana, Itália",
              grapeType: "Cabernet Sauvignon / Sangiovese",
              notes: "Cassis / Amora / Alcaçuz",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0022,
              name: "Harlan Estate",
              origin: "Napa Valley, EUA",
              grapeType: "Cabernet Sauvignon",
              notes: "Cassis / Anis / Chocolate",
              idealTemperature: 19.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0023,
              name: "Vega Sicilia Único",
              origin: "Ribera del Duero, Espanha",
              grapeType: "Tinto Fino",
              notes: "Cereja Negra / Cacau / Cedro",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0024,
              name: "Château Latour",
              origin: "Bordeaux, França",
              grapeType: "Cabernet Sauvignon",
              notes: "Cassis / Alcaçuz / Tabaco",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0025,
              name: "Le Pin",
              origin: "Pomerol, França",
              grapeType: "Merlot",
              notes: "Cereja / Floral / Baunilha",
              idealTemperature: 17.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0026,
              name: "Dominus",
              origin: "Napa Valley, EUA",
              grapeType: "Cabernet Sauvignon / Cabernet Franc",
              notes: "Cassis / Amora / Ervas",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0027,
              name: "Château Leoville-Las Cases",
              origin: "Bordeaux, França",
              grapeType: "Cabernet Sauvignon / Merlot",
              notes: "Cassis / Cereja Preta / Cedro",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0028,
              name: "Montevertine Le Pergole Torte",
              origin: "Toscana, Itália",
              grapeType: "Sangiovese",
              notes: "Cereja / Ervas Secas / Baunilha",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0029,
              name: "Schrader Cellars CCS Beckstoffer To Kalon Vineyard",
              origin: "Napa Valley, EUA",
              grapeType: "Cabernet Sauvignon",
              notes: "Cassis / Café / Chocolate",
              idealTemperature: 19.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0030,
              name: "Château Haut-Brion",
              origin: "Bordeaux, França",
              grapeType: "Merlot / Cabernet Sauvignon",
              notes: "Cassis / Tabaco / Terracota",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0031,
              name: "Dominio de Pingus",
              origin: "Ribera del Duero, Espanha",
              grapeType: "Tinto Fino",
              notes: "Cereja / Cacau / Especiarias",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0032,
              name: "Clos des Papes Châteauneuf-du-Pape",
              origin: "Rhône, França",
              grapeType: "Grenache / Syrah",
              notes: "Amora / Alcaçuz / Ervas",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0033,
              name: "Masseto",
              origin: "Toscana, Itália",
              grapeType: "Merlot",
              notes: "Cereja / Chocolate / Baunilha",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0034,
              name: "Joseph Phelps Insignia",
              origin: "Napa Valley, EUA",
              grapeType: "Cabernet Sauvignon / Merlot",
              notes: "Cassis / Amora / Café",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0035,
              name: "Château Cheval Blanc",
              origin: "Bordeaux, França",
              grapeType: "Merlot / Cabernet Franc",
              notes: "Cassis / Violeta / Alcaçuz",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0036,
              name: "Penfolds Bin 707",
              origin: "South Australia",
              grapeType: "Cabernet Sauvignon",
              notes: "Cassis / Eucalipto / Chocolate",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0037,
              name: "Grgich Hills Estate Cabernet Sauvignon",
              origin: "Napa Valley, EUA",
              grapeType: "Cabernet Sauvignon",
              notes: "Cassis / Cereja / Baunilha",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0038,
              name: "Château Angelus",
              origin: "Bordeaux, França",
              grapeType: "Merlot / Cabernet Franc",
              notes: "Cassis / Amora / Café",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0039,
              name: "Château Lynch-Bages",
              origin: "Bordeaux, França",
              grapeType: "Cabernet Sauvignon / Merlot",
              notes: "Cassis / Tabaco / Pimenta",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0040,
              name: "Krug Grande Cuvée",
              origin: "Champagne, França",
              grapeType: "Chardonnay / Pinot Noir / Pinot Meunier",
              notes: "Maçã / Brioche / Nozes",
              idealTemperature: 10.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0041,
              name: "Sine Qua Non",
              origin: "Califórnia, EUA",
              grapeType: "Variedades Múltiplas",
              notes: "Frutas Exóticas / Mel / Floral",
              idealTemperature: 14.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0042,
              name: "Château Trotanoy",
              origin: "Pomerol, França",
              grapeType: "Merlot / Cabernet Franc",
              notes: "Cassis / Cereja / Couro",
              idealTemperature: 17.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0043,
              name: "Harlan The Maiden",
              origin: "Napa Valley, EUA",
              grapeType: "Cabernet Sauvignon / Merlot",
              notes: "Cassis / Amora / Chocolate",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0044,
              name: "Château Pavie",
              origin: "Bordeaux, França",
              grapeType: "Merlot / Cabernet Franc",
              notes: "Cassis / Violeta / Alcaçuz",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0045,
              name: "Chryseia",
              origin: "Douro, Portugal",
              grapeType: "Touriga Nacional / Touriga Franca",
              notes: "Amora / Especiarias / Baunilha",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0046,
              name: "Château Canon",
              origin: "Bordeaux, França",
              grapeType: "Merlot / Cabernet Franc",
              notes: "Cassis / Cereja / Violeta",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0047,
              name: "Sassicaia Bolgheri",
              origin: "Toscana, Itália",
              grapeType: "Cabernet Sauvignon / Cabernet Franc",
              notes: "Cassis / Eucalipto / Baunilha",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0048,
              name: "Clos Sainte Hune",
              origin: "Alsácia, França",
              grapeType: "Riesling",
              notes: "Limão / Flor de Laranjeira / Mineral",
              idealTemperature: 10.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0049,
              name: "Château Clinet",
              origin: "Pomerol, França",
              grapeType: "Merlot / Cabernet Franc",
              notes: "Cassis / Violeta / Terra",
              idealTemperature: 17.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0050,
              name: "Screaming Eagle",
              origin: "Napa Valley, EUA",
              grapeType: "Cabernet Sauvignon / Merlot / Cabernet Franc",
              notes: "Cassis / Amora / Baunilha",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0051,
              name: "Guigal Côte-Rôtie La Mouline",
              origin: "Rhône, França",
              grapeType: "Syrah / Viognier",
              notes: "Amora / Floral / Bacon",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0052,
              name: "Viña Tondonia",
              origin: "Rioja, Espanha",
              grapeType: "Tempranillo",
              notes: "Cereja / Couro / Tabaco",
              idealTemperature: 17.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0053,
              name: "Clarendon Hills Astralis",
              origin: "South Australia",
              grapeType: "Syrah",
              notes: "Amora / Chocolate / Pimenta",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
          Wine(
              id: 0054,
              name: "Antinori Tignanello",
              origin: "Toscana, Itália",
              grapeType: "Sangiovese / Cabernet Sauvignon",
              notes: "Cassis / Amora / Baunilha",
              idealTemperature: 18.0,
              rpClassification: 0,
              clientClassification: 0,
              bottle: '',
              quantity: 0),
        ],
      );

      await db.insert(
        'catalog',
        {'id': catalogId, 'winesList': jsonEncode(catalog.toJson()['wines'])},
      );
    }
  }

  Future<void> initializeClientCatalog(Database db) async {
    const catalogId = 00002;
    final countQuery = await db
        .rawQuery('SELECT COUNT(*) FROM catalog WHERE id = ?', [catalogId]);
    final int recordsCount = Sqflite.firstIntValue(countQuery) ?? 0;

    if (recordsCount == 0) {
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
            bottle: 'assets/bottles/chateau_margaux.png',
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
            bottle: 'assets/bottles/barolo-piemont.png',
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
            bottle: 'assets/bottles/las_beatas.png',
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
            bottle: 'assets/bottles/covela.png',
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
            bottle: 'assets/bottles/sancerre.png',
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
            bottle: 'assets/bottles/brunello-di-montalcino.png',
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

  Future<void> removeWineFromCatalog(int catalogId, int wineId) async {
    try {
      final catalog = await getCatalog(catalogId);

      if (catalog == null) {
        print('Catalog not found with id: $catalogId');
        return;
      }

      catalog.wines.removeWhere((wine) => wine.id == wineId);

      db = await DatabaseManager.instance.database;

      await db.update(
        'catalog',
        {'winesList': json.encode(catalog.toJson()['wines'])},
        where: 'id = ?',
        whereArgs: [catalogId],
      );
    } catch (e) {
      print("Error removing wine from catalog: $e");
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
