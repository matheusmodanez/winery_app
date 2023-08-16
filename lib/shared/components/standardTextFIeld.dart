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
          label: Text(
            label,
            style: const TextStyle(
                fontFamily: 'Poppins', color: Color.fromARGB(255, 58, 58, 58)),
          ),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide()),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 197, 27, 78))),
          fillColor: Colors.white,
          focusColor: Colors.white,
        ),
        style: const TextStyle(),
        validator: validator,
      ),
    );
  }
}
