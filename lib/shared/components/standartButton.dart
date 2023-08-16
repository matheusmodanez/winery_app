import 'package:flutter/material.dart';

class ButtonStyleParams {
  final Color backgroundColor;
  final double textSize;
  final double height;

  ButtonStyleParams({
    required this.backgroundColor,
    required this.textSize,
    required this.height,
  });
}

class StandardButton extends StatelessWidget {
  final String buttonText;
  final Function()? onPressed;
  final ButtonStyleParams styleParams;

  const StandardButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      required this.styleParams});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        height: styleParams.height,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: styleParams.backgroundColor),
          onPressed: onPressed,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: styleParams.textSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
