import 'package:Winery/features/Catalog/catalogRepository.dart';
import 'package:Winery/features/profile/profileRepository.dart';
import 'package:Winery/features/wine/wineryCatalogRepository.dart';
import 'package:Winery/resources/userDataManager.dart';
import 'package:Winery/shared/components/standartButton.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final _catalogRepository = CatalogRepository();
  final _wineryRepository = WineryRepository();
  final _profileRepository = ProfileRepository();
  late UserDataManager _userDataManager;

  @override
  void initState() {
    super.initState();
    _userDataManager = UserDataManager(
        _catalogRepository, _profileRepository, _wineryRepository);
    loadUserData();
  }

  Future<void> loadUserData() async {
    final loadedProfile = await _userDataManager.loadProfile();
    final loadedCatalog =
        await _userDataManager.loadCatalog(loadedProfile.catalogId!);

    await _userDataManager.saveUserData(loadedProfile, loadedCatalog);
  }

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
                'assets/logos/logo.png',
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
