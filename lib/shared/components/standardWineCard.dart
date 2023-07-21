import 'package:flutter/material.dart';

class StandardWineCard extends StatelessWidget {
  final String name;
  final String origin;
  final String notes;
  final double idealTemperature;
  final double rpClassification;
  final double clientClassification;

  StandardWineCard({
    super.key,
    required this.name,
    required this.origin,
    required this.notes,
    required this.idealTemperature,
    required this.rpClassification,
    required this.clientClassification,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 150,
            height: 150,
            child: Image(
              image: AssetImage('assets/chateau_margaux.png'),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(name,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
          const SizedBox(
            height: 15,
          ),
          Text(origin,
              style: const TextStyle(fontSize: 16, color: Colors.white)),
          const SizedBox(
            height: 5,
          ),
          Text('$idealTemperature °C',
              style: const TextStyle(fontSize: 16, color: Colors.white))
        ],
      ),
    );
  }
}
