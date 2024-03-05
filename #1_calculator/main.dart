import 'package:flutter/material.dart';
import 'widgets/display.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _display = '';
  double _result = 0;
  String _operator = '';
  double _operand = 0;

  void _onPressed(String value) {
    setState(() {
      if (value == '+' || value == '-' || value == '*' || value == '/') {
        _operator = value;
        _operand = double.tryParse(_display) ?? 0;
        _display = '';
      } else if (value == '=') {
        double currentNumber = double.tryParse(_display) ?? 0;
        switch (_operator) {
          case '+':
            _result = _operand + currentNumber;
            break;
          case '-':
            _result = _operand - currentNumber;
            break;
          case '*':
            _result = _operand * currentNumber;
            break;
          case '/':
            _result = _operand / currentNumber;
            break;
          default:
            _result = 0;
        }
        _display = _result.toString();
        _operator = '';
        _operand = 0;
      } else {
        _display += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Calculator')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Display(value: _display),
          // RowウィジェットでCalculatorButtonウィジェットを並べて配置...
        ],
      ),
    );
  }
}