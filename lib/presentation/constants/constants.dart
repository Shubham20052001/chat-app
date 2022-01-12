import 'package:flutter/material.dart';

AppBar myAppBar(BuildContext context) {
  return AppBar(
    title: const Text('Flutter Chat App'),
    elevation: 0.0,
  );
}

InputDecoration textFieldInputDecoration({required String hintText}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(
      color: Colors.white54,
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  );
}

TextStyle simpleTextStyle() {
  return const TextStyle(color: Colors.white, fontSize: 16);
}
