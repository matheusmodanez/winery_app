import 'dart:convert';

import 'package:Winery/features/catalog/catalogProvider.dart';
import 'package:Winery/shared/components/standardWineManagementCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Winery/domain/entities/catalog.dart';
import 'package:Winery/shared/components/standartButton.dart';
import 'package:Winery/domain/entities/wine.dart';

class CatalogManagementPage extends StatefulWidget {
  const CatalogManagementPage({Key? key}) : super(key: key);

  @override
  State<CatalogManagementPage> createState() => _CatalogManagementPageState();
}

class _CatalogManagementPageState extends State<CatalogManagementPage> {
  Future<List<Wine>>? _futureCatalogWines;
  late int catalogId;

  @override
  void initState() {
    super.initState();
    _loadWines();
  }

  void _loadWines() async {
    final prefs = await SharedPreferences.getInstance();

    final catalogJson = prefs.getString('catalog');
    if (catalogJson != null) {
      final Map<String, dynamic> catalogData = jsonDecode(catalogJson);
      final catalog = Catalog.fromJson(catalogData);
      setState(() {
        _futureCatalogWines = Future.value(catalog.wines);
      });

      catalogId = catalog.id!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Wine>>(
        future: _futureCatalogWines,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching data'),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            final wines = snapshot.data ?? [];
            return _buildContent(wines);
          }
          return const Text("A");
        },
      ),
    );
  }

  Widget _buildContent(List<Wine> wines) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCatalogWines(wines),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: StandardButton(
                  buttonText: "Adicionar Manualmente",
                  onPressed: () {
                    Navigator.pushNamed(context, '/newWine');
                  },
                  styleParams: ButtonStyleParams(
                      backgroundColor: const Color.fromARGB(255, 106, 16, 59),
                      textSize: 14,
                      height: 45),
                ),
              ),
              Flexible(
                child: StandardButton(
                  buttonText: "Catálogo Winery",
                  onPressed: () {
                    Navigator.pushNamed(context, '/wineryCatalog');
                  },
                  styleParams: ButtonStyleParams(
                      backgroundColor: const Color.fromARGB(255, 106, 16, 59),
                      textSize: 14,
                      height: 45),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCatalogWines(List<Wine> wines) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
      child: Consumer<CatalogProvider>(
        builder: (context, catalogProvider, child) {
          final wines = catalogProvider.catalog.wines;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Seu catálogo',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: wines.length,
                  itemBuilder: (context, index) {
                    final wine = wines[index];
                    return StandardWineManagementCard(
                      catalogId: catalogId,
                      wine: wine,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
