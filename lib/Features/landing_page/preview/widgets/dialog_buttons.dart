import 'package:flutter/material.dart';

Widget dialogButton(String title, Function() onTap) {
  return TextButton(
    child: Text(title),
    onPressed: onTap,
  );
}
