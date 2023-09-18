import 'package:Winery/features/catalog/catalogProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/wine.dart';

class LastAccessedWinesList extends StatelessWidget {
  final List<Wine> lastAccessedWines;

  const LastAccessedWinesList({Key? key, required this.lastAccessedWines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child:
          Consumer<CatalogProvider>(builder: (context, catalogProvider, child) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: lastAccessedWines.length,
          itemBuilder: (context, index) {
            final wine = lastAccessedWines[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/wineDetails',
                  arguments: wine,
                );
              },
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 179, 150, 150),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  Positioned.fill(
                    child: Visibility(
                      visible: wine.bottle.isNotEmpty,
                      child: Image(
                        image: AssetImage(wine.bottle),
                      ),
                    ),
                  ),
                  // Positioned.fill(
                  //   child: Align(
                  //     alignment: Alignment.bottomCenter,
                  //     child: Text(
                  //       wine.name,
                  //       textAlign: TextAlign.center,
                  //       style: const TextStyle(
                  //         color: Color.fromARGB(255, 106, 16, 59),
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
