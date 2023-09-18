import 'package:Winery/domain/entities/wine.dart';
import 'package:Winery/features/catalog/catalogProvider.dart';
import 'package:Winery/features/catalog/catalogRepository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StandardWineManagementCard extends StatefulWidget {
  final Wine wine;
  final int catalogId;

  const StandardWineManagementCard({
    Key? key,
    required this.wine,
    required this.catalogId,
  }) : super(key: key);

  @override
  _StandardWineManagementCardState createState() =>
      _StandardWineManagementCardState();
}

class _StandardWineManagementCardState
    extends State<StandardWineManagementCard> {
  int _quantity = 0;
  final _catalogRepository = CatalogRepository();

  @override
  void initState() {
    super.initState();
    _quantity = widget.wine.quantity;
  }

  void updateWineQuantityProvider() {
    final wineId = widget.wine.id;
    final quantity = _quantity;
    if (wineId != null) {
      context.read<CatalogProvider>().updateWineQuantity(wineId, quantity);
      context.read<CatalogProvider>().calculateTotalBottles();
    }
  }

  void updateWineQuantity(int catalogId, int wineId, int quantity) {
    _catalogRepository.updateWineQuantity(
        widget.catalogId, widget.wine.id!, _quantity);
    context
        .read<CatalogProvider>()
        .updateWineQuantity(widget.wine.id!, _quantity);
  }

  void _confirmRemoveWine() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Confirme a remoção',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          content: const Text(
            'Tem certeza que quer remover esse vinho do seu catálogo?',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color.fromARGB(255, 197, 27, 78)),
              ),
            ),
            TextButton(
              onPressed: () async {
                context.read<CatalogProvider>().removeWine(widget.wine.id!);
                await _catalogRepository.removeWineFromCatalog(
                    widget.catalogId, widget.wine.id!);
                Navigator.pop(context);
              },
              child: const Text(
                'Confirmar',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color.fromARGB(255, 197, 27, 78)),
              ),
            ),
          ],
        );
      },
    );
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
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Column(
          children: [
            SizedBox(
              width: 150,
              height: 65,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () async {
                    if (_quantity > 0) {
                      setState(() {
                        _quantity--;
                        widget.wine.quantity = _quantity;
                      });
                      updateWineQuantity(
                          widget.catalogId, widget.wine.id!, _quantity);
                    } else {
                      _confirmRemoveWine();
                    }
                  },
                  color: Colors.white,
                ),
                Text(
                  '${widget.wine.quantity}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    setState(() {
                      _quantity++;
                      widget.wine.quantity = _quantity;
                    });

                    updateWineQuantity(
                        widget.catalogId, widget.wine.id!, _quantity);
                  },
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
