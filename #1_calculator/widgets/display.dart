import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  final String value;
  final bool isHistory;

  Display({required this.value, this.isHistory = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.bottomRight,
      child: Text(
        value,
        style: TextStyle(
            fontSize: isHistory ? 24 : 48,
            fontWeight: isHistory ? FontWeight.normal : FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
