import 'package:Winery/shared/components/customBottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:object_3d/object_3d.dart';

class WineryModel extends StatefulWidget {
  const WineryModel({super.key});

  @override
  State<WineryModel> createState() => _WineryModelState();
}

class _WineryModelState extends State<WineryModel> {
  int paginaAtual = 1;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.75,
            child: const ModelViewer(
              src: 'assets/wineryModel.glb',
              alt: 'A 3D model',
              ar: true,
              autoRotate: true,
              cameraControls: true,
              backgroundColor: Colors.transparent,
            ),
          ),
          const SizedBox(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Controle da Adega',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 106, 16, 59),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Temperatura',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 106, 16, 59),
                      ),
                    ),
                    Text(
                      'Umidade',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 106, 16, 59),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: paginaAtual,
        onTap: setPaginaAtual,
      ),
    );
  }

  void setPaginaAtual(int pagina) {
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
