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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 185,
                  height: 275,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 106, 16, 59),
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
            ],
          ),
        ),
      ),
    );
  }
}
