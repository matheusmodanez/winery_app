import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/components/customBottomNavigationBar.dart';
import '../../shared/components/standardLastAccessesItem.dart';
import '../../shared/components/standardWineItem.dart';
import 'package:Winery/domain/entities/wine.dart';
import 'package:Winery/features/Catalog/catalogRepository.dart';
import 'package:Winery/features/Catalog/wineManageProvider.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final _catalogRepository = CatalogRepository();
  late Future<List<Wine>> _futureWineList;
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
    _loadWines();
  }

  void _loadWines() {
    _futureWineList = _catalogRepository.listWines();
  }

  void _addLastAccessedWine(Wine wine) {
    final wineManagerProvider =
        Provider.of<WineManageProvider>(context, listen: false);
    wineManagerProvider.addLastAccessedWine(wine);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Wine>>(
        future: _futureWineList,
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
                  const SizedBox(height: 65),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Winery',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
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
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
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
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
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
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
              ),
              scrollDirection: Axis.vertical,
              itemCount: wines.length,
              itemBuilder: (context, index) {
                final wine = wines[index];
                return StandardWineItem(
                  wine: wine,
                  onTap: (wine) {
                    _addLastAccessedWine(wine);
                    Navigator.pushNamed(
                      context,
                      '/wineDetails',
                      arguments: wine,
                    );
                  },
                );
              },
            ),
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
        Navigator.pushNamed(context, '/');
        break;
      case 2:
        Navigator.pushNamed(context, '/management');
        break;
    }
  }
}
