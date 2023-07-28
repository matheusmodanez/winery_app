import 'package:flutter/material.dart';
import '../../domain/entities/wine.dart';

class LastAccessedWinesList extends StatelessWidget {
  final List<Wine> lastAccessedWines;

  const LastAccessedWinesList({Key? key, required this.lastAccessedWines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Positioned.fill(
                  child: Image(
                    image: AssetImage(wine.bottle),
                    fit: BoxFit.contain,
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
      ),
    );
  }
}
