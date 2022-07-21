import 'package:flutter/material.dart';

InputDecoration customTextFieldInputDecoration(String label) {
  return InputDecoration(
    label: Text(label),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.blue),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
