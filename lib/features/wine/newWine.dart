import 'dart:convert';

import 'package:Winery/domain/entities/catalog.dart';
import 'package:Winery/domain/entities/wine.dart';
import 'package:Winery/features/catalog/catalogProvider.dart';
import 'package:Winery/shared/components/standardTextFIeld.dart';
import 'package:Winery/shared/components/standartButton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewWine extends StatefulWidget {
  Wine? editableWine;
  NewWine({Key? key, this.editableWine}) : super(key: key);

  @override
  State<NewWine> createState() => _NewWineState();
}

class _NewWineState extends State<NewWine> {
  late int catalogId;

  final _wineNameCrontoller = TextEditingController();
  final _wineOriginCrontoller = TextEditingController();
  final _wineGrapeTypeCrontoller = TextEditingController();
  final _wineNotesCrontoller = TextEditingController();
  final _wineIdetalTempController = TextEditingController();
  final _wineBottleQuantity = TextEditingController();

  @override
  void initState() {
    super.initState();

    final wine = widget.editableWine;
    if (wine != null) {
      _wineNameCrontoller.text = wine.name;
      _wineOriginCrontoller.text = wine.origin;
      _wineGrapeTypeCrontoller.text = wine.grapeType;
      _wineNotesCrontoller.text = wine.notes;
      _wineIdetalTempController.text = wine.idealTemperature as String;
      // ''= wine.bottle;
      _wineBottleQuantity.text = wine.quantity as String;
    }
    _loadWines();
  }

  void _loadWines() async {
    final prefs = await SharedPreferences.getInstance();

    final catalogJson = prefs.getString('catalog');
    if (catalogJson != null) {
      final Map<String, dynamic> catalogData = jsonDecode(catalogJson);
      final catalog = Catalog.fromJson(catalogData);
      catalogId = catalog.id!;
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Adicionar vinho ao catálogo',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            _buildForm(context),
          ],
        ),
      ),
    );
  }

  Form _buildForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              const SizedBox(height: 5),
              StandardTextField(
                  label: 'Nome do Vinho',
                  userInputController: _wineNameCrontoller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe um Nome';
                    }
                    if (value.length < 3 || value.length > 12) {
                      return 'O campo deve ter entre 3 e 12 caracteres';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name),
              const SizedBox(height: 10),
              StandardTextField(
                  label: 'Origem',
                  userInputController: _wineOriginCrontoller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe a origem do vinho';
                    }
                    if (value.length < 3 || value.length > 35) {
                      return 'O campo deve ter entre 3 e 35 caracteres';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name),
              const SizedBox(height: 10),
              StandardTextField(
                  label: 'Tipo de Uva',
                  userInputController: _wineGrapeTypeCrontoller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe um Tipo de Uva';
                    }
                    if (value.length < 2 || value.length > 20) {
                      return 'O campo deve ter entre 2 e 20 caracteres';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name),
              const SizedBox(height: 10),
              StandardTextField(
                  label: 'Notas',
                  userInputController: _wineNotesCrontoller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe as notas que compõe o vinho';
                    }
                    if (value.length < 3 || value.length > 100) {
                      return 'O campo deve ter entre 3 e 100 caracteres';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name),
              const SizedBox(height: 10),
              StandardTextField(
                  label: 'Temperatura ideal',
                  userInputController: _wineIdetalTempController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe a temperatura ideal';
                    }
                    if (value.length < 2 || value.length > 4) {
                      return 'O campo deve ter entre 2 e 4 caracteres';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number),
              const SizedBox(height: 10),
              StandardTextField(
                  label: 'Quantidade de Garrafas',
                  userInputController: _wineBottleQuantity,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe um valor';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number),
              const SizedBox(
                height: 50,
              ),
              StandardButton(
                  buttonText: 'Salvar',
                  onPressed: () async {
                    final isValid = _formKey.currentState!.validate();
                    if (isValid) {
                      final name = _wineNameCrontoller.text;
                      final origin = _wineOriginCrontoller.text;
                      final grapeType = _wineGrapeTypeCrontoller.text;
                      final notes = _wineNotesCrontoller.text;
                      final idealTemperature = NumberFormat.decimalPattern()
                          .parse(_wineIdetalTempController.text)
                          .toDouble();
                      const rpClassification = 0.0;
                      const clientClassification = 0.0;
                      const bottle = '';
                      final quantity = NumberFormat.decimalPattern()
                          .parse(_wineBottleQuantity.text)
                          .toInt();

                      final wine = Wine(
                          name: name,
                          origin: origin,
                          grapeType: grapeType,
                          notes: notes,
                          idealTemperature: idealTemperature,
                          rpClassification: rpClassification,
                          clientClassification: clientClassification,
                          bottle: bottle,
                          quantity: quantity);

                      try {
                        final catalogProvider = Provider.of<CatalogProvider>(
                            context,
                            listen: false);
                        catalogProvider.addWine(wine);

                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Vinho adicionado com Sucesso!')));

                        Navigator.pushNamed(context, '/');
                      } catch (e) {
                        Navigator.of(context).pop(false);
                      }
                    }
                  },
                  styleParams: ButtonStyleParams(
                      backgroundColor: const Color.fromARGB(255, 106, 16, 59),
                      textSize: 14,
                      height: 45))
            ])));
  }
}
