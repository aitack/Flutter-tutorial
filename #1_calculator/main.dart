import 'package:flutter/material.dart';
import 'widgets/calculator_button.dart';
import 'widgets/display.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Flutter Calculator'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.calculate)),
                Tab(icon: Icon(Icons.history)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Calculator(),
              HistoryTab(),
            ],
          ),
        ),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _display = '0';
  String _history = '';
  bool _isResultDisplayed = false;

  void _onPressed(String value) {
    setState(() {
      if (_isResultDisplayed && RegExp(r'[0-9]').hasMatch(value)) {
        _display = value;
        _isResultDisplayed = false;
      } else if (_isResultDisplayed && RegExp(r'[+\-*/]').hasMatch(value)) {
        _display += value;
        _isResultDisplayed = false;
      } else if (value == 'C') {
        // クリアボタンが押された場合、重複する履歴を追加しない
        if (_isResultDisplayed && (_history.isNotEmpty || _display != '0')) {
          String potentialHistory = _history + '=' + _display;
          if (HistoryTab.getLastHistory() != potentialHistory) {
            HistoryTab.addHistory(potentialHistory);
          }
        }
        _display = '0';
        _history = '';
        _isResultDisplayed = false;
      } else if (value == '=') {
        try {
          _history = _display;
          _display = _evaluate(_display);
          _isResultDisplayed = true;
          // '='を押したときに履歴を追加
          HistoryTab.addHistory(_history + '=' + _display);
        } catch (e) {
          _display = 'Error';
          _isResultDisplayed = false;
        }
      } else {
        if (_display == '0' || _isResultDisplayed) {
          _display = value;
          _isResultDisplayed = false;
        } else {
          _display += value;
        }
      }
    });
  }

  String _evaluate(String expression) {
    Parser p = Parser();
    Expression exp;
    try {
      exp = p.parse(expression);
    } catch (e) {
      return 'Error';
    }
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    return eval.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Display(value: _history, isHistory: true),
        Display(value: _display),
        Row(
          children: <Widget>[
            CalculatorButton(label: '7', onPressed: _onPressed),
            CalculatorButton(label: '8', onPressed: _onPressed),
            CalculatorButton(label: '9', onPressed: _onPressed),
            CalculatorButton(label: '/', onPressed: _onPressed),
          ],
        ),
        Row(
          children: <Widget>[
            CalculatorButton(label: '4', onPressed: _onPressed),
            CalculatorButton(label: '5', onPressed: _onPressed),
            CalculatorButton(label: '6', onPressed: _onPressed),
            CalculatorButton(label: '*', onPressed: _onPressed),
          ],
        ),
        Row(
          children: <Widget>[
            CalculatorButton(label: '1', onPressed: _onPressed),
            CalculatorButton(label: '2', onPressed: _onPressed),
            CalculatorButton(label: '3', onPressed: _onPressed),
            CalculatorButton(label: '-', onPressed: _onPressed),
          ],
        ),
        Row(
          children: <Widget>[
            CalculatorButton(label: 'C', onPressed: _onPressed),
            CalculatorButton(label: '0', onPressed: _onPressed),
            CalculatorButton(label: '=', onPressed: _onPressed),
            CalculatorButton(label: '+', onPressed: _onPressed),
          ],
        ),
      ],
    );
  }
}

class HistoryTab extends StatelessWidget {
  static final List<String> _historyList = [];

  static void addHistory(String history) {
    _historyList.insert(0, history); // 新しい履歴を先頭に追加
  }

  static void clearHistory() {
    _historyList.clear(); // 履歴リストを空にする
  }

  static String getLastHistory() {
    return _historyList.isNotEmpty ? _historyList.first : '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  // 履歴をクリアする処理
                  clearHistory();
                  // UIを更新するために状態変更をトリガー
                  (context as Element).markNeedsBuild();
                },
                child: Text('Clear History'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _historyList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_historyList[index], textAlign: TextAlign.right),
              );
            },
          ),
        ),
      ],
    );
  }
}
