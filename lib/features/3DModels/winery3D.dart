import 'dart:convert';
import 'dart:async';
import 'package:Winery/shared/components/customBottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WineryModel extends StatefulWidget {
  const WineryModel({super.key});

  @override
  State<WineryModel> createState() => _WineryModelState();
}

class _WineryModelState extends State<WineryModel> {
  int paginaAtual = 1;
  late String temp = '';
  late int humidity = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    getWineryTemperature();
    getWineryHumidity();
    pc = PageController(initialPage: paginaAtual);
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<void> getWineryTemperature() async {
    final url = Uri.parse(
        'https://api2.arduino.cc/iot/v2/things/bb5888a4-6f33-4e0d-9e1c-95f954896c88/properties/203c6f85-55d7-419f-a92a-78c96affcda5');

    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');

    final headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(url, headers: headers);
      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          temp = jsonResponse['last_value'].toStringAsFixed(1);
        });
      } else {
        print('Erro na solicitação: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro de rede: $e');
    }
  }

  Future<void> getWineryHumidity() async {
    final url = Uri.parse(
        'https://api2.arduino.cc/iot/v2/things/bb5888a4-6f33-4e0d-9e1c-95f954896c88/properties/c87f4e7a-7e75-4003-9568-4effeb68e25d');

    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');

    final headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(url, headers: headers);
      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          humidity = jsonResponse['last_value'];
        });
      } else {
        print('Erro na solicitação: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro de rede: $e');
    }
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
          SizedBox(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
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
                      'Temperatura $temp ℃',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 106, 16, 59),
                      ),
                    ),
                    Text(
                      'Umidade  $humidity %',
                      style: const TextStyle(
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
