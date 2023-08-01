import 'package:flutter/material.dart';
import 'package:Winery/domain/entities/wine.dart';

typedef WineTapCallback = void Function(Wine wine);

class StandardWineItem extends StatelessWidget {
  final Wine wine;
  final WineTapCallback onTap;

  const StandardWineItem({
    Key? key,
    required this.wine,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            onTap(wine);
            Navigator.pushNamed(context, '/wineDetails', arguments: wine);
          },
          child: SizedBox(
            width: 250,
            height: 350,
            child: _buildCard(),
          ),
        ),
      ),
    );
  }

  Widget _buildCard() {
    return DecoratedBox(
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
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          width: 150,
          height: 125,
          child: Column(
            children: [
              SizedBox(
                width: 150,
                height: 85,
                child: Image(
                  image: AssetImage(wine.bottle),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                wine.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
