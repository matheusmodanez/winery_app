import 'dart:convert';

import 'package:Winery/domain/entities/catalog.dart';
import 'package:Winery/domain/entities/profile.dart';
import 'package:Winery/features/catalog/catalogProvider.dart';
import 'package:Winery/shared/components/standartButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/components/customBottomNavigationBar.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key}) : super(key: key);

  @override
  _ManagementPageState createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  late PageController pc;
  int paginaAtual = 2;

  late Profile loadedProfile;
  late Catalog loadedCatalog = Catalog(id: null, wines: []);

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = prefs.getString('profile');
    final catalogJson = prefs.getString('catalog');

    if (profileJson != null && catalogJson != null) {
      final Map<String, dynamic> profileData = jsonDecode(profileJson);
      final Map<String, dynamic> catalogData = jsonDecode(catalogJson);

      setState(() {
        loadedProfile = Profile.fromJson(profileData);
        loadedCatalog = Catalog.fromJson(catalogData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 75, 5, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        const Color.fromARGB(255, 197, 27, 78).withOpacity(1),
                    width: 6,
                  ),
                ),
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(loadedProfile.profilePicture),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              loadedProfile.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: 1,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 45, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<CatalogProvider>(
                        builder: (context, bottleCountProvider, child) {
                      return const Text('Número de garrafas:  ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            height: 1,
                          ));
                    }),
                    Consumer<CatalogProvider>(
                        builder: (context, catalogProvider, child) {
                      return Text(
                        '${catalogProvider.totalBottles}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Capacidade da Adega:  ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        )),
                    Text(
                      '${loadedProfile.wineryCapacity}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            StandardButton(
                buttonText: "Editar Perfil",
                onPressed: () {},
                styleParams: ButtonStyleParams(
                    backgroundColor: const Color.fromARGB(255, 106, 16, 59),
                    textSize: 14,
                    height: 45)),
            const SizedBox(
              height: 15,
            ),
            StandardButton(
                buttonText: "Gerenciar Catálogo",
                onPressed: () {
                  Navigator.pushNamed(context, '/catalogManagement');
                },
                styleParams: ButtonStyleParams(
                    backgroundColor: const Color.fromARGB(255, 106, 16, 59),
                    textSize: 14,
                    height: 45)),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: paginaAtual,
        onTap: (pagina) {
          setPaginaAtual(pagina);
        },
      ),
    );
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });

    switch (pagina) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/wineryModel');
        break;
      case 2:
        Navigator.pushNamed(context, '/management');
        break;
    }
  }
}
