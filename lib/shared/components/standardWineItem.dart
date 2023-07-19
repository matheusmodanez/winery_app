import 'package:flutter/material.dart';
import 'package:winery_app/domain/entities/wine.dart';
import 'package:winery_app/shared/components/standardWineCard.dart';

class StandardWineItem extends StatelessWidget {
  final Wine wine;
  const StandardWineItem({Key? key, required this.wine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 20,
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          // onTap: () {
          //   Navigator.pushNamed(context, '/sale-details', arguments: wine);
          // },
          child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 47, 11, 209).withOpacity(0.1),
                    const Color.fromARGB(255, 47, 11, 209).withOpacity(0.8),
                  ],
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: StandardWineCard(
                name: wine.name,
                origin: wine.origin,
                notes: wine.notes,
                idealTemperature: wine.idealTemperature,
                rpClassification: wine.rpClassification,
                clientClassification: wine.clientClassification,
              )),
        ),
      ),
    );
  }
}
