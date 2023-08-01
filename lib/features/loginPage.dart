import 'package:Winery/shared/components/standartButton.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 212, 197, 168)),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
            top: 125,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 45,
              ),
              Image.asset(
                'assets/logo.png',
                fit: BoxFit.cover,
                height: 250,
              ),
              const SizedBox(
                height: 100,
              ),
              StandardButton(
                buttonText: 'Login',
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
