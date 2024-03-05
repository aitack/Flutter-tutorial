import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String label;
  final void Function(String) onPressed;

  CalculatorButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () => onPressed(label),
        child: Text(label, style: TextStyle(fontSize: 24)),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(24),
        ),
      ),
    );
  }
}
