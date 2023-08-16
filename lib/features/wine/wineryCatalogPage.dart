import 'dart:convert';

import 'package:Winery/domain/entities/catalog.dart';
import 'package:Winery/domain/entities/wine.dart';
import 'package:Winery/features/catalog/catalogProvider.dart';
import 'package:Winery/shared/components/standardWineryManagementCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resources/userDataManager.dart';
import '../catalog/catalogRepository.dart';
import '../profile/profileRepository.dart';

class WineryCatalogPage extends StatefulWidget {
  const WineryCatalogPage({Key? key}) : super(key: key);

  @override
  State<WineryCatalogPage> createState() => _WineryCatalogPageState();
}

class _WineryCatalogPageState extends State<WineryCatalogPage> {
  final _catalogRepository = CatalogRepository();
  final _profileRepository = ProfileRepository();
  late UserDataManager _userDataManager;
  Future<List<Wine>>? _futureWineryCatalog;
  late int _catalogId;

  @override
  void initState() {
    super.initState();
    _userDataManager = UserDataManager(_catalogRepository, _profileRepository);
    loadUserData();
    _loadWineryCatalog();
  }

  Future<void> loadUserData() async {
    final loadedProfile = await _userDataManager.loadProfile();
    _catalogId = loadedProfile.catalogId!;
  }

  void _loadWineryCatalog() async {
    final prefs = await SharedPreferences.getInstance();

    final wineryCatalogJson = prefs.getString('wineryCatalog');
    if (wineryCatalogJson != null) {
      final Map<String, dynamic> wineryCatalogData =
          jsonDecode(wineryCatalogJson);
      final wineryCatalog = Catalog.fromJson(wineryCatalogData);
      setState(() {
        _futureWineryCatalog = Future.value(wineryCatalog.wines);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Wine>>(
        future: _futureWineryCatalog,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Text('Error fetching data');
          } else if (snapshot.connectionState == ConnectionState.done) {
            final wines = snapshot.data ?? [];
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Catálogo Winery',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  _buildCatalogWines(wines),
                ],
              ),
            );
          }
          return const Text("A");
        },
      ),
    );
  }

  Widget _buildCatalogWines(List<Wine> wines) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 10, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 1,
            child: Consumer<CatalogProvider>(
                builder: (context, catalogProvider, child) {
              final wines = catalogProvider.wineryCatalog.wines;
              return GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                ),
                scrollDirection: Axis.vertical,
                itemCount: wines.length,
                itemBuilder: (context, index) {
                  final wine = wines[index];
                  return StandardWineryManagementCard(
                    catalogId: _catalogId,
                    wine: wine,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
