import 'package:Winery/domain/entities/wine.dart';
import 'package:Winery/shared/components/standartButton.dart';
import 'package:flutter/material.dart';

class StandardWineryManagementCard extends StatefulWidget {
  final Wine wine;

  const StandardWineryManagementCard({
    Key? key,
    required this.wine,
  }) : super(key: key);

  @override
  _StandardWineryManagementCardState createState() =>
      _StandardWineryManagementCardState();
}

class _StandardWineryManagementCardState
    extends State<StandardWineryManagementCard> {
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
            StandardButton(buttonText: 'Adicionar', onPressed: () {})
          ],
        ),
      ),
    );
  }
}
