import 'package:Winery/domain/entities/wine.dart';
import 'package:Winery/features/catalog/catalogProvider.dart';
import 'package:Winery/features/catalog/catalogRepository.dart';
import 'package:Winery/shared/components/standartButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StandardWineryManagementCard extends StatefulWidget {
  final Wine wine;
  final int catalogId;

  const StandardWineryManagementCard({
    Key? key,
    required this.wine,
    required this.catalogId,
  }) : super(key: key);

  @override
  _StandardWineryManagementCardState createState() =>
      _StandardWineryManagementCardState();
}

class _StandardWineryManagementCardState
    extends State<StandardWineryManagementCard> {
  final _catalogRepository = CatalogRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
      child: _buildCard(),
    );
  }

  Widget _buildCard() {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 197, 27, 78).withOpacity(1),
            const Color.fromARGB(255, 106, 16, 59).withOpacity(1),
          ],
          begin: AlignmentDirectional.topCenter,
          end: AlignmentDirectional.center,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
        child: Column(
          children: [
            SizedBox(
              width: 150,
              height: 70,
              child: Visibility(
                visible: widget.wine.bottle.isNotEmpty,
                child: Image(
                  image: AssetImage(widget.wine.bottle),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              widget.wine.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            StandardButton(
                buttonText: 'Adicionar',
                onPressed: () async {
                  try {
                    widget.wine.quantity = 1;

                    final catalogProvider =
                        Provider.of<CatalogProvider>(context, listen: false);
                    catalogProvider.addWine(widget.wine);

                    await _catalogRepository.addWineToCatalog(
                        widget.catalogId, widget.wine);

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Vinho adicionado com Sucesso!')));

                    Navigator.pushNamed(context, '/');
                  } catch (e) {
                    Navigator.of(context).pop(false);
                  }
                },
                styleParams: ButtonStyleParams(
                    backgroundColor: const Color.fromARGB(255, 197, 27, 78),
                    textSize: 10,
                    height: 25))
          ],
        ),
      ),
    );
  }
}
