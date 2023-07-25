import 'package:flutter/material.dart';
import 'package:Winery/domain/entities/wine.dart';

typedef WineTapCallback = void Function(Wine wine);

class StandardWineItem extends StatelessWidget {
  final Wine wine;
  final WineTapCallback onTap;

  StandardWineItem({
    Key? key,
    required this.wine,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 15,
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            onTap(wine);
            Navigator.pushNamed(context, '/wineDetails', arguments: wine);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: 250,
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 197, 27, 78).withOpacity(1),
                        const Color.fromARGB(255, 106, 16, 59).withOpacity(1),
                      ],
                      begin: AlignmentDirectional.topCenter,
                      end: AlignmentDirectional.center,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: Image(
                            image: AssetImage(wine.bottle),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(wine.name,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(wine.origin,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white)),
                        const SizedBox(
                          height: 5,
                        ),
                        Text('${wine.idealTemperature} °C',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white))
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
