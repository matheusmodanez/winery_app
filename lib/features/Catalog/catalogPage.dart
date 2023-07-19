import 'package:flutter/material.dart';
import 'package:winery_app/domain/entities/wine.dart';
import 'package:winery_app/features/Catalog/catalogRepository.dart';
import 'package:winery_app/shared/components/standardWineItem.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPage();
}

class _CatalogPage extends State<CatalogPage> {
  final _catalogRepository = CatalogRepository();
  late Future<List<Wine>> _futureWineList;

  @override
  void initState() {
    listWines();
    super.initState();
  }

  void listWines() {
    _futureWineList = _catalogRepository.listWines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Winery')),
        body: FutureBuilder<List<Wine>>(
            future: _futureWineList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                final wines = snapshot.data ?? [];
                return ListView.builder(
                    itemCount: wines.length,
                    itemBuilder: (context, index) {
                      final wine = wines[index];
                      return StandardWineItem(wine: wine);
                    });
              }
              return Container();
            }));
  }
}
