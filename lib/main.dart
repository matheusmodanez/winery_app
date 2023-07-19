import 'package:flutter/material.dart';
import 'package:winery_app/features/Catalog/catalogPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Winery',
      debugShowCheckedModeBanner: false,
      // theme: lightTheme,
      routes: {
        '/': (context) => const CatalogPage(),
      },
      initialRoute: '/',
    );
  }
}
