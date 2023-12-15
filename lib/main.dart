import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final List<String> operators = ["+", "-", "x", "÷"];
  final List<String> hist = [];
  var history = "", output = "", answer = 0.0;

  FocusNode clearButtonFocus = FocusNode();

  void click(int number) {
    setState(() {
      if (double.parse(output) != 0.0) {
        output += number.toString();
      } else {
        output = number.toString();
      }
    });
  }

  void clickDot() {
    setState(() {
      output += ".";
    });
  }

  void clear() {
    setState(() {
      history = "";
      output = "0";
      answer = 0.0;
      hist.clear();
    });
  }

  void sign() {
    setState(() {
      if (double.parse(output) != 0.0) {
        output = (output[0] == '-') ? output.substring(1) : "-$output";
      }
    });
  }

  void percent() {
    setState(() {
      final double percent = answer = answer / 100;
      history = '$answer ÷ 100 =';
      output = percent.toString();
    });
  }

  String getTape() {
    return hist.join(" ");
  }

  bool isOperator(String s) {
    return operators.contains(s);
  }

  void equals() {
    setState(() {
      if (hist.length <= 3) {
        hist.add(output);
      }
      history = '${getTape()} =';
      final opr1 = double.parse(hist.removeAt(0));
      final op = hist.removeAt(0);
      final opr2 = double.parse(hist.removeAt(0));
      switch (op) {
        case "+":
          answer = opr1 + opr2;
          break;
        case "-":
          answer = opr1 - opr2;
          break;
        case "*":
          answer = opr1 * opr2;
          break;
        case "÷":
          answer = opr1 / opr2;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
