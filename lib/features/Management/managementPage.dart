import 'package:Winery/shared/components/standartButton.dart';
import 'package:flutter/material.dart';

import '../../shared/components/customBottomNavigationBar.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key}) : super(key: key);

  @override
  _ManagementPageState createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  int paginaAtual = 2;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 55, 5, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Align(
              alignment: AlignmentDirectional(0, 0),
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/papa.png'),
              ),
            ),
            const SizedBox(
                height: 10), // Adjust the spacing between image and text
            const Text(
              'Luigi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: 1,
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 45, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Número de garrafas',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        )),
                    Text('1050',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          height: 2,
                        )),
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
        Navigator.pushNamed(context, '/');
        break;
      case 2:
        Navigator.pushNamed(context, '/management');
        break;
    }
  }
}
