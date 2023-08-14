import 'package:flutter/material.dart';

class StandardTextField extends StatelessWidget {
  final String label;
  final Function()? onEditingComplete;
  final TextEditingController? userInputController;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final double? height;

  StandardTextField(
      {required this.label,
      required this.userInputController,
      this.onEditingComplete,
      this.focusNode,
      required this.validator,
      this.height,
      required TextInputType keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: TextFormField(
        focusNode: focusNode,
        controller: userInputController,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          label: Text(label),
          border: const OutlineInputBorder(),
          fillColor: Colors.white,
          focusColor: Colors.white,
        ),
        style: const TextStyle(),
        validator: validator,
      ),
    );
  }
}
