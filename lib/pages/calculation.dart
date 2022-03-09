import 'package:flutter/material.dart';

class Calculation extends StatefulWidget {
  const Calculation({Key? key}) : super(key: key);

  @override
  State<Calculation> createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  String answer = "0";
  String answerTemp = "";
  String input = "";
  String operator = "";
  bool calculateMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เครื่องคิดเลข'),
      ),
      body: Column(
        children: <Widget>[
          buildAnswerWidget(),
          buildNumPadWidget(),
        ],
      ),
    );
  }

  Widget buildAnswerWidget() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        color: Color(0xffdbdbdb),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                input + " " + operator,
                style: TextStyle(fontSize: 18),
              ),
              Text(answer, style: TextStyle(fontSize: 48))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNumPadWidget() {
    return Container(
        color: Color(0xffdbdbdb),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(children: <Widget>[
              buildNumberButton("C", numberButton: false, onTap: () {
                clearAll();
              }),
              buildNumberButton("÷", numberButton: false, onTap: () {
                addOperatorToAnswer("÷");
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("7", onTap: () {
                addNumberToAnswer(7);
              }),
              buildNumberButton("8", onTap: () {
                addNumberToAnswer(8);
              }),
              buildNumberButton("9", onTap: () {
                addNumberToAnswer(9);
              }),
              buildNumberButton("x", numberButton: false, onTap: () {
                addOperatorToAnswer("x");
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("4", onTap: () {
                addNumberToAnswer(4);
              }),
              buildNumberButton("5", onTap: () {
                addNumberToAnswer(5);
              }),
              buildNumberButton("6", onTap: () {
                addNumberToAnswer(6);
              }),
              buildNumberButton("−", numberButton: false, onTap: () {
                addOperatorToAnswer("-");
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("1", onTap: () {
                addNumberToAnswer(1);
              }),
              buildNumberButton("2", onTap: () {
                addNumberToAnswer(2);
              }),
              buildNumberButton("3", onTap: () {
                addNumberToAnswer(3);
              }),
              buildNumberButton("+", numberButton: false, onTap: () {
                addOperatorToAnswer("+");
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("0", onTap: () {
                addNumberToAnswer(0);
              }),
              buildNumberButton("=", numberButton: false, onTap: () {
                calculate();
              }),
            ]),
          ],
        ));
  }

  Widget buildNumberButton(String str,
      {required Function() onTap, bool numberButton = true}) {
    Widget widget;
    if (numberButton) {
      widget = Container(
        margin: const EdgeInsets.all(1.0),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
              height: 70,
              child: Center(
                child: Text(str, style: TextStyle(fontSize: 20)),
              ),
            ),
          ),
        ),
      );
    } else {
      widget = Container(
        margin: const EdgeInsets.all(1.0),
        child: Material(
          color: Color(0xffecf0f1),
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
              height: 70,
              child: Center(
                child: Text(str, style: const TextStyle(fontSize: 15)),
              ),
            ),
          ),
        ),
      );
    }
    return Expanded(child: widget);
  }

  void clearAll() {
    setState(() {
      answer = "0";
      input = "";
      calculateMode = false;
      operator = "";
    });
  }

  void calculate() {
    setState(() {
      if (calculateMode) {
        double value = 0;
        if (operator == "+") {
          value = (double.parse(answerTemp) + double.parse(answer));
        } else if (operator == "-") {
          value = (double.parse(answerTemp) - double.parse(answer));
        } else if (operator == "x") {
          value = (double.parse(answerTemp) * double.parse(answer));
        } else if (operator == "÷") {
          value = (double.parse(answerTemp) / double.parse(answer));
        }
        answer = value.toInt().toString();

        calculateMode = false;
        operator = "";
        answerTemp = "";
        input = "";
      }
    });
  }

  void addOperatorToAnswer(String op) {
    setState(() {
      if (answer != "0" && !calculateMode) {
        calculateMode = true;
        answerTemp = answer;
        input += operator + " " + answerTemp;
        operator = op;
        answer = "0";
      } else if (calculateMode) {
        if (answer.isNotEmpty) {
          calculate();
          answerTemp = answer;
          input = "";
          operator = "";
        } else {
          operator = op;
        }
      }
    });
  }

  void addNumberToAnswer(int number) {
    setState(() {
      if (number == 0 && answer == "0") {
      } else if (number != 0 && answer == "0") {
        answer = number.toString();
      } else {
        answer += number.toString();
      }
    });
  }

}
