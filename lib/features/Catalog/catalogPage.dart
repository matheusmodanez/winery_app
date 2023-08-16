import 'dart:convert';

import 'package:Winery/domain/entities/catalog.dart';
import 'package:Winery/features/catalog/catalogProvider.dart';
import 'package:Winery/features/wine/wineManageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/components/customBottomNavigationBar.dart';
import '../../shared/components/standardLastAccessesItem.dart';
import '../../shared/components/standardWineItem.dart';
import 'package:Winery/domain/entities/wine.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  int paginaAtual = 0;
  late PageController pc;

  Future<List<Wine>>? _futureClientCatalog;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
    _loadWines();
  }

  void _loadWines() async {
    final prefs = await SharedPreferences.getInstance();

    final catalogJson = prefs.getString('catalog');
    if (catalogJson != null) {
      final Map<String, dynamic> catalogData = jsonDecode(catalogJson);
      final catalog = Catalog.fromJson(catalogData);
      setState(() {
        _futureClientCatalog = Future.value(catalog.wines);
      });
    }
  }

  void _addLastAccessedWine(Wine wine) {
    final wineManagerProvider = context.read<WineManageProvider>();
    wineManagerProvider.addLastAccessedWine(wine);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Wine>>(
        future: _futureClientCatalog,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Text('Error fetching data');
          } else if (snapshot.connectionState == ConnectionState.done) {
            final wines = snapshot.data ?? [];
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 25),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Winery',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        height: 2,
                      ),
                    ),
                  ),
                  _buildLastAccessedWines(),
                  _buildCatalogWines(wines),
                ],
              ),
            );
          }
          return const Text("A");
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: paginaAtual,
        onTap: setPaginaAtual,
      ),
    );
  }

  Widget _buildLastAccessedWines() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recentemente acessado',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          Consumer<WineManageProvider>(
            builder: (context, wineManagerProvider, _) {
              final lastAccessedWines = wineManagerProvider.lastAccessedWines;
              return LastAccessedWinesList(
                lastAccessedWines: lastAccessedWines,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCatalogWines(List<Wine> wines) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Seu catálogo',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Consumer<CatalogProvider>(
                builder: (context, catalogProvider, child) {
              final wines = catalogProvider.catalog.wines;
              return GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                ),
                scrollDirection: Axis.vertical,
                itemCount: wines.length,
                itemBuilder: (context, index) {
                  final wine = wines[index];
                  return StandardWineItem(
                    wine: wine,
                    onTap: (wine) {
                      _addLastAccessedWine(wine);
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void setPaginaAtual(int pagina) {
    setState(() {
      paginaAtual = pagina;
    });

    switch (pagina) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/wineryModel');
        break;
      case 2:
        Navigator.pushNamed(context, '/management');
        break;
    }
  }
}
