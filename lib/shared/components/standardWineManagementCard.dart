import 'package:Winery/domain/entities/wine.dart';
import 'package:Winery/features/Catalog/catalogRepository.dart';
import 'package:Winery/features/catalog/catalogProvider.dart';
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
    }
  }

  void updateWineQuantity(int catalogId, int wineId, int quantity) {
    _catalogRepository.updateWineQuantity(
        widget.catalogId, widget.wine.id!, _quantity);
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
                visible:
                    widget.wine.bottle != null && widget.wine.bottle.isNotEmpty,
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
