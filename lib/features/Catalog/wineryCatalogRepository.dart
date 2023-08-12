import 'package:sqflite/sqflite.dart';

class CatalogRepository {
  late Database db;

  Future<void> insertInitialWines(Database db) async {
    final count = await db.rawQuery('SELECT COUNT(*) FROM wine');
    final int recordsCount = Sqflite.firstIntValue(count) ?? 0;

    if (recordsCount == 0) {
      await db.insert("wineryCatalog", {
        "id": 0002,
        "name": "Château Lafite Rothschild",
        "origin": "Bordeaux, França",
        "grapeType": "Cabernet Sauvignon",
        "notes": "Cassis / Cedro / Tabaco",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0003,
        "name": "Opus One",
        "origin": "Napa Valley, EUA",
        "grapeType": "Cabernet Sauvignon",
        "notes": "Cereja Preta / Baunilha / Café",
        "idealTemperature": 19.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0004,
        "name": "Barolo Monfortino",
        "origin": "Piemonte, Itália",
        "grapeType": "Nebbiolo",
        "notes": "Cereja / Rosa / Alcatrão",
        "idealTemperature": 17.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0005,
        "name": "Rioja Alta Gran Reserva 904",
        "origin": "Rioja, Espanha",
        "grapeType": "Tempranillo",
        "notes": "Cereja Madura / Couro / Baunilha",
        "idealTemperature": 17.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0006,
        "name": "Penfolds Grange",
        "origin": "South Australia",
        "grapeType": "Shiraz",
        "notes": "Amora Preta / Chocolate / Pimenta",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0007,
        "name": "Sassicaia",
        "origin": "Toscana, Itália",
        "grapeType": "Cabernet Sauvignon",
        "notes": "Cassis / Eucalipto / Baunilha",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0008,
        "name": "Château d'Yquem",
        "origin": "Bordeaux, França",
        "grapeType": "Sémillon",
        "notes": "Mel / Damasco / Baunilha",
        "idealTemperature": 12.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0009,
        "name": "Dom Pérignon",
        "origin": "Champagne, França",
        "grapeType": "Chardonnay / Pinot Noir",
        "notes": "Maçã Verde / Amêndoa / Brioche",
        "idealTemperature": 8.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0010,
        "name": "Almaviva",
        "origin": "Maipo Valley, Chile",
        "grapeType": "Cabernet Sauvignon",
        "notes": "Cassis / Cereja / Pimenta",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0011,
        "name": "Château Palmer",
        "origin": "Bordeaux, França",
        "grapeType": "Merlot / Cabernet Sauvignon",
        "notes": "Cassis / Violeta / Tabaco",
        "idealTemperature": 17.0,
        "bottle": '',
      });

      await db.insert("wineryCatalog", {
        "id": 0013,
        "name": "Château Mouton Rothschild",
        "origin": "Bordeaux, França",
        "grapeType": "Cabernet Sauvignon",
        "notes": "Cassis / Pimenta / Cedro",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0014,
        "name": "Tignanello",
        "origin": "Toscana, Itália",
        "grapeType": "Sangiovese / Cabernet Sauvignon",
        "notes": "Cereja / Ervas / Baunilha",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0015,
        "name": "Caymus Special Selection",
        "origin": "Napa Valley, EUA",
        "grapeType": "Cabernet Sauvignon",
        "notes": "Cassis / Chocolate / Canela",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0016,
        "name": "Château Margaux Pavillon Rouge",
        "origin": "Bordeaux, França",
        "grapeType": "Cabernet Sauvignon / Merlot",
        "notes": "Cassis / Violeta / Couro",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0017,
        "name": "Solaia",
        "origin": "Toscana, Itália",
        "grapeType": "Cabernet Sauvignon / Sangiovese",
        "notes": "Cassis / Amora / Alcaçuz",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0018,
        "name": "Harlan Estate",
        "origin": "Napa Valley, EUA",
        "grapeType": "Cabernet Sauvignon",
        "notes": "Cassis / Anis / Chocolate",
        "idealTemperature": 19.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0019,
        "name": "Vega Sicilia Único",
        "origin": "Ribera del Duero, Espanha",
        "grapeType": "Tinto Fino",
        "notes": "Cereja Negra / Cacau / Cedro",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0020,
        "name": "Château Latour",
        "origin": "Bordeaux, França",
        "grapeType": "Cabernet Sauvignon",
        "notes": "Cassis / Alcaçuz / Tabaco",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0021,
        "name": "Le Pin",
        "origin": "Pomerol, França",
        "grapeType": "Merlot",
        "notes": "Cereja / Floral / Baunilha",
        "idealTemperature": 17.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0022,
        "name": "Dominus",
        "origin": "Napa Valley, EUA",
        "grapeType": "Cabernet Sauvignon / Cabernet Franc",
        "notes": "Cassis / Amora / Ervas",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0023,
        "name": "Château Leoville-Las Cases",
        "origin": "Bordeaux, França",
        "grapeType": "Cabernet Sauvignon / Merlot",
        "notes": "Cassis / Cereja Preta / Cedro",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0024,
        "name": "Montevertine Le Pergole Torte",
        "origin": "Toscana, Itália",
        "grapeType": "Sangiovese",
        "notes": "Cereja / Ervas Secas / Baunilha",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0025,
        "name": "Schrader Cellars CCS Beckstoffer To Kalon Vineyard",
        "origin": "Napa Valley, EUA",
        "grapeType": "Cabernet Sauvignon",
        "notes": "Cassis / Café / Chocolate",
        "idealTemperature": 19.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0026,
        "name": "Château Haut-Brion",
        "origin": "Bordeaux, França",
        "grapeType": "Merlot / Cabernet Sauvignon",
        "notes": "Cassis / Tabaco / Terracota",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0027,
        "name": "Dominio de Pingus",
        "origin": "Ribera del Duero, Espanha",
        "grapeType": "Tinto Fino",
        "notes": "Cereja / Cacau / Especiarias",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0028,
        "name": "Clos des Papes Châteauneuf-du-Pape",
        "origin": "Rhône, França",
        "grapeType": "Grenache / Syrah",
        "notes": "Amora / Alcaçuz / Ervas",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0029,
        "name": "Masseto",
        "origin": "Toscana, Itália",
        "grapeType": "Merlot",
        "notes": "Cereja / Chocolate / Baunilha",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0030,
        "name": "Joseph Phelps Insignia",
        "origin": "Napa Valley, EUA",
        "grapeType": "Cabernet Sauvignon / Merlot",
        "notes": "Cassis / Amora / Café",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0031,
        "name": "Château Cheval Blanc",
        "origin": "Bordeaux, França",
        "grapeType": "Merlot / Cabernet Franc",
        "notes": "Cassis / Violeta / Alcaçuz",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0032,
        "name": "Penfolds Bin 707",
        "origin": "South Australia",
        "grapeType": "Cabernet Sauvignon",
        "notes": "Cassis / Eucalipto / Chocolate",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0033,
        "name": "Grgich Hills Estate Cabernet Sauvignon",
        "origin": "Napa Valley, EUA",
        "grapeType": "Cabernet Sauvignon",
        "notes": "Cassis / Cereja / Baunilha",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0034,
        "name": "Château Angelus",
        "origin": "Bordeaux, França",
        "grapeType": "Merlot / Cabernet Franc",
        "notes": "Cassis / Amora / Café",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0035,
        "name": "Château Lynch-Bages",
        "origin": "Bordeaux, França",
        "grapeType": "Cabernet Sauvignon / Merlot",
        "notes": "Cassis / Tabaco / Pimenta",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0036,
        "name": "Krug Grande Cuvée",
        "origin": "Champagne, França",
        "grapeType": "Chardonnay / Pinot Noir / Pinot Meunier",
        "notes": "Maçã / Brioche / Nozes",
        "idealTemperature": 10.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0037,
        "name": "Sine Qua Non",
        "origin": "Califórnia, EUA",
        "grapeType": "Variedades Múltiplas",
        "notes": "Frutas Exóticas / Mel / Floral",
        "idealTemperature": 14.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0038,
        "name": "Château Trotanoy",
        "origin": "Pomerol, França",
        "grapeType": "Merlot / Cabernet Franc",
        "notes": "Cassis / Cereja / Couro",
        "idealTemperature": 17.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0040,
        "name": "Harlan The Maiden",
        "origin": "Napa Valley, EUA",
        "grapeType": "Cabernet Sauvignon / Merlot",
        "notes": "Cassis / Amora / Chocolate",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0041,
        "name": "Château Pavie",
        "origin": "Bordeaux, França",
        "grapeType": "Merlot / Cabernet Franc",
        "notes": "Cassis / Violeta / Alcaçuz",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0042,
        "name": "Chryseia",
        "origin": "Douro, Portugal",
        "grapeType": "Touriga Nacional / Touriga Franca",
        "notes": "Amora / Especiarias / Baunilha",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0043,
        "name": "Château Canon",
        "origin": "Bordeaux, França",
        "grapeType": "Merlot / Cabernet Franc",
        "notes": "Cassis / Cereja / Violeta",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0044,
        "name": "Sassicaia Bolgheri",
        "origin": "Toscana, Itália",
        "grapeType": "Cabernet Sauvignon / Cabernet Franc",
        "notes": "Cassis / Eucalipto / Baunilha",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0045,
        "name": "Clos Sainte Hune",
        "origin": "Alsácia, França",
        "grapeType": "Riesling",
        "notes": "Limão / Flor de Laranjeira / Mineral",
        "idealTemperature": 10.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0047,
        "name": "Château Clinet",
        "origin": "Pomerol, França",
        "grapeType": "Merlot / Cabernet Franc",
        "notes": "Cassis / Violeta / Terra",
        "idealTemperature": 17.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0048,
        "name": "Screaming Eagle",
        "origin": "Napa Valley, EUA",
        "grapeType": "Cabernet Sauvignon / Merlot / Cabernet Franc",
        "notes": "Cassis / Amora / Baunilha",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0049,
        "name": "Guigal Côte-Rôtie La Mouline",
        "origin": "Rhône, França",
        "grapeType": "Syrah / Viognier",
        "notes": "Amora / Floral / Bacon",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0050,
        "name": "Viña Tondonia",
        "origin": "Rioja, Espanha",
        "grapeType": "Tempranillo",
        "notes": "Cereja / Couro / Tabaco",
        "idealTemperature": 17.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0051,
        "name": "Clarendon Hills Astralis",
        "origin": "South Australia",
        "grapeType": "Syrah",
        "notes": "Amora / Chocolate / Pimenta",
        "idealTemperature": 18.0,
        "bottle": '',
      });
      await db.insert("wineryCatalog", {
        "id": 0052,
        "name": "Antinori Tignanello",
        "origin": "Toscana, Itália",
        "grapeType": "Sangiovese / Cabernet Sauvignon",
        "notes": "Cassis / Amora / Baunilha",
        "idealTemperature": 18.0,
        "bottle": '',
      });
    }
  }
}
