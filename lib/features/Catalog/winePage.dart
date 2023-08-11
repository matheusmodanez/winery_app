import 'package:Winery/features/Catalog/wineManageProvider.dart';
import 'package:flutter/material.dart';
import 'package:Winery/domain/entities/wine.dart';
import 'package:Winery/features/Catalog/catalogRepository.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:Winery/shared/components/standardGlassCards.dart';
import 'package:Winery/shared/components/standartButton.dart';
import 'package:provider/provider.dart';

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

  void updateWineRating(double newRating) {
    final wineId = widget.wine?.id;
    if (wineId != null) {
      context.read<WineManageProvider>().updateWineRating(wineId, newRating);
    }
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
          .map(
            (term) => GlassCard(
                start: 0.1,
                end: 0.1,
                width: 85,
                height: 60,
                text1: term,
                text2: '',
                text1Size: 12,
                text2Size: 10),
          )
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
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 500,
                    width: 600,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color.fromARGB(255, 197, 27, 78)
                                .withOpacity(1),
                            const Color.fromARGB(255, 106, 16, 59)
                                .withOpacity(1),
                          ],
                          begin: AlignmentDirectional.topCenter,
                          end: AlignmentDirectional.center,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 35, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
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
                                Wrap(
                                  children: [
                                    Text(
                                      wine.name,
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                              child: RatingBar.builder(
                                onRatingUpdate: (newValue) {
                                  updateWineRating(newValue);
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
                                          color: Color.fromARGB(
                                              255, 202, 202, 202),
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
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 75,
                                    ),
                                    GlassCard(
                                        start: 0.1,
                                        end: 0.1,
                                        width: 115,
                                        height: 75,
                                        text1: wine.grapeType,
                                        text2: "Tipo",
                                        text1Size: 16,
                                        text2Size: 14),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    GlassCard(
                                        start: 0.1,
                                        end: 0.1,
                                        width: 115,
                                        height: 75,
                                        text1:
                                            "${getCountryFlagEmoji(wine.origin)} ${wine.origin}",
                                        text2: "Origem",
                                        text1Size: 14,
                                        text2Size: 12),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    GlassCard(
                                        start: 0.1,
                                        end: 0.1,
                                        width: 115,
                                        height: 75,
                                        text1: '${wine.idealTemperature} ºC',
                                        text2: "Temperatura \n Ideal",
                                        text1Size: 16,
                                        text2Size: 14),
                                  ],
                                ),
                                SizedBox(
                                  width: 100,
                                  height: 450,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 50, 0, 0),
                                    child: Image(
                                      image: AssetImage(wine.bottle),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 55,
                                    ),
                                    const Text("Notas",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 177, 177, 177),
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        )),
                                    ...textWidgets
                                        .map((widget) => Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: widget,
                                            ))
                                        .toList(),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 100, 15, 0),
                child: SizedBox(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Quantidade de garrafas: ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 31, 31, 31),
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )),
                    Text('${wine.quantity}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 31, 31, 31),
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 35, 0, 15),
                child: SizedBox(
                  child: StandardButton(
                    buttonText: 'Localizar Vinho',
                    onPressed: () {},
                  ),
                ),
              ),
            ],
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
