import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String hintext;
  final TextEditingController controller;
  final TextInputType inputType;

  CustomTextField({
    required this.hintext,
    required this.controller,
    required this.inputType,
});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      controller: controller,
      decoration: InputDecoration(
        labelText: hintext,
        hintText: hintext,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
    );
  }
}
