import 'package:flutter/material.dart';
import 'package:Winery/domain/entities/wine.dart';
import 'package:Winery/features/Catalog/catalogRepository.dart';
import 'package:Winery/shared/components/standardWineItem.dart';

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
    print(_futureWineList);
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
              return GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 110,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: wines.length,
                  itemBuilder: (context, index) {
                    final wine = wines[index];
                    return StandardWineItem(wine: wine);
                  });
            }
            return const Text("A");
          }),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 106, 16, 59),
          iconSize: 30,
          selectedIconTheme: const IconThemeData(color: Colors.white),
          selectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedIconTheme: const IconThemeData(
            color: Color.fromARGB(255, 126, 126, 126),
          ),
          unselectedItemColor: const Color.fromARGB(255, 126, 126, 126),
          currentIndex: paginaAtual,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.wine_bar), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: ''),
          ],
          onTap: (pagina) {
            pc.animateToPage(
              pagina,
              duration: const Duration(milliseconds: 400),
              curve: Curves.ease,
            );
          }),
    );
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }
}
