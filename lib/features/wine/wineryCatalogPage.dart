import 'package:Winery/domain/entities/wine.dart';
import 'package:Winery/features/catalog/catalogProvider.dart';
import 'package:Winery/shared/components/standardWineryManagementCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WineryCatalogPage extends StatefulWidget {
  const WineryCatalogPage({Key? key}) : super(key: key);

  @override
  State<WineryCatalogPage> createState() => _WineryCatalogPageState();
}

class _WineryCatalogPageState extends State<WineryCatalogPage> {
  Future<List<Wine>>? _futureWineList;

  @override
  void initState() {
    super.initState();
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
                  _buildCatalogWines(wines),
                ],
              ),
            );
          }
          return const Text("A");
        },
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
            'Catálogo Winery',
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
                  return StandardWineryManagementCard(
                    wine: wine,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
