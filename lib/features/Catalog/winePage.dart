import 'package:flutter/material.dart';
import 'package:winery_app/domain/entities/wine.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WineDetailsPage extends StatefulWidget {
  const WineDetailsPage({Key? key}) : super(key: key);

  @override
  State<WineDetailsPage> createState() => _WineDetailsPage();
}

class _WineDetailsPage extends State<WineDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wine = ModalRoute.of(context)!.settings.arguments as Wine;
    double classification = wine.clientClassification;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: 600,
          height: 300,
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
                  Align(
                    alignment: const AlignmentDirectional(-0.75, 0),
                    child: Text(wine.name,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                  ),
                ],
              ),
              Align(
                alignment: const AlignmentDirectional(-1, 0),
                child: RatingBar.builder(
                  onRatingUpdate: (newValue) => setState(() => newValue),
                  itemBuilder: (context, index) => const Icon(
                    Icons.star_rounded,
                    color: Colors.grey,
                  ),
                  direction: Axis.horizontal,
                  initialRating: classification,
                  unratedColor: Colors.grey,
                  itemCount: 5,
                  itemSize: 40,
                  glowColor: Colors.amber[600],
                ),
              ),
              SizedBox(
                width: 600,
                height: 300,
                child: Align(
                  child: Column(
                    children: [
                      const Text(
                        'Origem',
                      ),
                      Text(wine.origin),
                    ],
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
