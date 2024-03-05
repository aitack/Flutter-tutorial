import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String label;
  final void Function(String) onPressed;

  CalculatorButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () => onPressed(label),
          child: Text(
            label,
            style: TextStyle(fontSize: 24, color: Colors.black), // テキストの色を黒に設定
          ),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(24),
            foregroundColor: Colors.black, // ボタンのテキスト色とアイコン色を黒に設定
          ),
        ),
      ),
    );
  }
}
