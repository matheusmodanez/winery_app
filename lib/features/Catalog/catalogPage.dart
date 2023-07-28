import 'package:Winery/features/Catalog/wineManageProvider.dart';
import 'package:flutter/material.dart';
import 'package:Winery/domain/entities/wine.dart';
import 'package:Winery/features/Catalog/catalogRepository.dart';
import 'package:Winery/shared/components/standardWineItem.dart';
import 'package:provider/provider.dart';

import '../../shared/components/customBottomNavigationBar.dart';
import '../../shared/components/standardLastAccessesItem.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPage();
}

class _CatalogPage extends State<CatalogPage> {
  final _catalogRepository = CatalogRepository();
  late Future<List<Wine>> _futureWineList;
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    listWines();
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  void listWines() {
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
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final wines = snapshot.data ?? [];
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 65, 0, 20),
                    child: const Text(
                      'Winery',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: const Text(
                          'Recentemente acessado',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Consumer<WineManageProvider>(
                        builder: (context, wineManagerProvider, _) {
                          final lastAccessedWines =
                              wineManagerProvider.lastAccessedWines;
                          return LastAccessedWinesList(
                            lastAccessedWines: lastAccessedWines,
                          );
                        },
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: const Text(
                          'Seu catálogo',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true, // Added this line
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 110,
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
                    ],
                  ),
                ],
              ),
            );
          }
          return const Text("A");
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: paginaAtual,
        onTap: (pagina) {
          setPaginaAtual(pagina);
        },
      ),
    );
  }

  setPaginaAtual(pagina) {
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
