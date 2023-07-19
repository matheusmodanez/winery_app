import 'package:flutter/material.dart';

class StandardWineCard extends StatelessWidget {
  final String name;
  final String origin;
  final List<String> notes;
  final int idealTemperature;
  final int rpClassification;
  final int clientClassification;

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
              const SizedBox(
                height: 20,
              ),
              Text(
                origin,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
