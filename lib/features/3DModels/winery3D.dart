import 'package:Winery/shared/components/customBottomNavigationBar.dart';
import 'package:flutter/material.dart';
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
      body: const Object3D(
        size: Size(375.0, 500.0),
        path: 'assets/render02Triang.obj',
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
