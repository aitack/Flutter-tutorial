import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  final String value;

  Display({required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.bottomRight,
        child: Text(
          value,
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
