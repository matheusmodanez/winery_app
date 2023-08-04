import 'package:Winery/features/Catalog/catalogRepository.dart';
import 'package:Winery/shared/components/standartButton.dart';
import 'package:flutter/material.dart';
import 'package:Winery/domain/entities/wine.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WineDetailsPage extends StatefulWidget {
  final Wine? wine;

  const WineDetailsPage({Key? key, required this.wine}) : super(key: key);
  @override
  State<WineDetailsPage> createState() => _WineDetailsPage();
}

class _WineDetailsPage extends State<WineDetailsPage> {
  final _catalogRepository = CatalogRepository();
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  void updateClientClassification(int? id, double newClassification) {
    _catalogRepository.updateClientClassification(id, newClassification);
  }

  @override
  Widget build(BuildContext context) {
    final wine = widget.wine;

    if (wine == null) {
      return const Scaffold(
        body: Center(
          child: Text('Wine not found.'),
        ),
      );
    } else {
      double classification = wine.clientClassification;

      List<String> terms =
          wine.notes.split('/').map((term) => term.trim()).toList();

      List<Widget> textWidgets = terms
          .map((term) => Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 206, 206, 206),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    term,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ))
          .toList();

      String getCountryFlagEmoji(String country) {
        switch (wine.origin
            .toLowerCase()
            .split(',')
            .map((term) => term.trim())
            .last) {
          case 'frança':
            return '🇫🇷';
          case 'itália':
            return '🇮🇹';
          case 'espanha':
            return '🇪🇸';
          case 'portugal':
            return '🇵🇹';
          default:
            return '';
        }
      }

      return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: 600,
            child: Column(
              children: [
                Stack(
                  children: [
                    const ClipRRect(
                      child: Image(
                        image: AssetImage('assets/cover.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Text(
                            wine.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Sua Classificação',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 2)),
                        RatingBar.builder(
                          onRatingUpdate: (newValue) {
                            updateClientClassification(wine.id, newValue);
                          },
                          itemBuilder: (context, index) {
                            return index < wine.clientClassification
                                ? const Icon(
                                    Icons.star_rounded,
                                    color: Colors.amber,
                                  )
                                : const Icon(
                                    Icons.star_rounded,
                                    color: Color.fromARGB(255, 202, 202, 202),
                                  );
                          },
                          direction: Axis.horizontal,
                          initialRating: classification,
                          unratedColor:
                              const Color.fromARGB(255, 202, 202, 202),
                          itemCount: 5,
                          itemSize: 40,
                          glowColor: Colors.amber[600],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 600,
                  height: 75,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Origem',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1,
                              )),
                          Text(getCountryFlagEmoji(wine.origin) + wine.origin,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                height: 2,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 600,
                  height: 75,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Tipo de Uva',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1),
                          ),
                          Text(wine.grapeType,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                height: 2,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 600,
                  height: 125,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Notas',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                height: 1),
                          ),
                          Wrap(
                            spacing: 8,
                            runSpacing: 2,
                            children: textWidgets,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 600,
                  height: 150,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Text('Monitoramento',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    height: 1)),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Row(
                              children: [
                                const Text('Temperatura Ideal',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        height: 1)),
                                const Icon(Icons.thermostat),
                                Text('${wine.idealTemperature} ºC',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        height: 1)),
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: StandardButton(
                                buttonText: 'Localizar Vinho',
                                onPressed: () {},
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }
}
