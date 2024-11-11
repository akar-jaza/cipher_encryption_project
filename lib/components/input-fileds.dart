import 'package:flutter/material.dart';

Row inputField({
  required TextEditingController controller,
  required IconData icon,
  String labelText = '',
  bool showAlphabet = false,
}) {
  if (showAlphabet && controller.text.isEmpty) {
    controller.text = "abcdefghijklmnopqrstuvwxyz";
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Icon(
        icon,
        size: 40,
        color: ColorScheme.fromSeed(seedColor: Colors.blue).primary,
      ),
      const SizedBox(width: 20),
      Expanded(
        child: TextField(
          controller: controller,
          maxLines: null,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: labelText,
          ),
        ),
      ),
    ],
  );
}
