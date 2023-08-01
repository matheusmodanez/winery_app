import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: kBottomNavigationBarHeight,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 47, 0, 22)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 0),
              _buildNavItem(Icons.wine_bar, 1),
              _buildNavItem(Icons.account_circle, 2),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData iconData, int index) {
    final isSelected = index == currentIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.white : Colors.transparent,
        ),
        child: Icon(
          iconData,
          color: isSelected
              ? const Color.fromARGB(255, 197, 27, 78)
              : Colors.white,
        ),
      ),
    );
  }
}
