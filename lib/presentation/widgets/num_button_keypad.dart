import 'package:flutter/material.dart';

class KeypadNumButton extends StatelessWidget {
  final Widget label;
  final VoidCallback onPressed;

  const KeypadNumButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onPressed, child: Center(child: label));
  }
}
