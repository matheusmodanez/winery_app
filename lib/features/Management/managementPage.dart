import 'package:Winery/domain/entities/profile.dart';
import 'package:Winery/features/Catalog/catalogRepository.dart';
import 'package:Winery/features/Management/profileManagement/profileRepository.dart';
import 'package:Winery/shared/components/standartButton.dart';
import 'package:flutter/material.dart';

import '../../shared/components/customBottomNavigationBar.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key}) : super(key: key);

  @override
  _ManagementPageState createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  final _catalogRepository = CatalogRepository();
  final _profileRepository = ProfileRepository();
  late Future<Profile> profile;
  late Profile loadedProfile;
  late int _totalBottles;
  late PageController pc;
  int paginaAtual = 2;

  @override
  void initState() {
    super.initState();
    loadProfileInfo();
    _calculateTotalBottles();
    pc = PageController(initialPage: paginaAtual);
  }

  Future<void> _calculateTotalBottles() async {
    final total = await _catalogRepository.calculateTotalBottles();
    setState(() {
      _totalBottles = total;
    });
  }

  void loadProfileInfo() async {
    profile = _profileRepository.loadProfile(0001);
    loadedProfile = await profile;
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Número de garrafas',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        )),
                    Text(
                      '${loadedProfile.quantity}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        height: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            StandardButton(buttonText: "Editar Perfil", onPressed: () {}),
            const SizedBox(
              height: 25,
            ),
            StandardButton(buttonText: "Gerenciar Catálogo", onPressed: () {}),
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
