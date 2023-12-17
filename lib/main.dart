import 'package:flutter/material.dart';
import 'package:github_project/my_colors.dart';

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
  final List<String> operators = ["+", "-", "×", "÷"];
  final List<String> hist = [];
  var history = "", output = "", answer = 0.0;

  FocusNode clearButtonFocus = FocusNode(); // این خط اضافه شده است

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
      final double percent = answer / 100;
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
        case "×":
          answer = opr1 * opr2;
          break;
        case "÷":
          answer = opr1 / opr2;
          break;
        default:
      }
      output = answer.toString();
      hist.insert(0, answer.toString());
    });
  }

  void operate(String operation) {
    setState(() {
      answer = double.parse(output);
      hist.add(output);
      hist.add(operation);
      if (hist.length >= 3) {
        output = "0";
        equals();
      }
      output = "0";
      history = getTape();
    });
  }

  void add() => operate("+");

  void sub() => operate("-");

  void div() => operate("÷");

  void mul() => operate("×");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: SolidColors.mainColor,
        title: const Text(
          "Calculator",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 25.0, right: 15.0),
            child: Text(
              history,
              overflow: TextOverflow.fade,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w200,
                color: SolidColors.mainColor,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
              right: 15.0,
              bottom: 15.0,
            ),
            child: Text(
              output,
              overflow: TextOverflow.fade,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 60.0,
                color: SolidColors.mainColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: clear,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: SolidColors.mainColor,
                  padding: const EdgeInsets.all(15.0),
                  focusNode: clearButtonFocus,
                  // این خط اضافه شده است
                  child: const Icon(
                    Icons.power_settings_new_outlined,
                    size: 35.0,
                    color: Colors.white,
                  ),
                ),
                RawMaterialButton(
                  onPressed: sign,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: SolidColors.mainColor,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "±",
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                RawMaterialButton(
                  onPressed: percent,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: SolidColors.mainColor,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "%",
                    style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                RawMaterialButton(
                  onPressed: div,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  highlightColor: SolidColors.mainColor,
                  splashColor: Colors.red[100],
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "÷",
                    style: TextStyle(
                      fontSize: 35.0,
                      color: SolidColors.mainColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: () => click(1),
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: SolidColors.mainColor,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "1",
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                RawMaterialButton(
                  onPressed: () => click(2),
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: SolidColors.mainColor,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "2",
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                RawMaterialButton(
                  onPressed: () => click(3),
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: SolidColors.mainColor,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "3",
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                RawMaterialButton(
                  onPressed: mul,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  highlightColor: Colors.red[100],
                  splashColor: Colors.red[100],
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "×",
                    style: TextStyle(
                      fontSize: 35.0,
                      color: SolidColors.mainColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: () => click(4),
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: SolidColors.mainColor,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "4",
                    style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                RawMaterialButton(
                  onPressed: () => click(5),
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: SolidColors.mainColor,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "5",
                    style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                RawMaterialButton(
                  onPressed: () => click(6),
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: SolidColors.mainColor,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "6",
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                RawMaterialButton(
                  onPressed: sub,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  highlightColor: Colors.red[100],
                  splashColor: Colors.red[100],
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "-",
                    style: TextStyle(
                      fontSize: 35.0,
                      color: SolidColors.mainColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: () => click(7),
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: SolidColors.mainColor,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "7",
                    style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                RawMaterialButton(
                  onPressed: () => click(8),
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: SolidColors.mainColor,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "8",
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                RawMaterialButton(
                  onPressed: () => click(9),
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: SolidColors.mainColor,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "9",
                    style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                RawMaterialButton(
                  onPressed: add,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  highlightColor: Colors.red[100],
                  splashColor: Colors.red[100],
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "+",
                    style: TextStyle(
                      fontSize: 35.0,
                      color: SolidColors.mainColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 5.0, bottom: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: () => click(0),
                  constraints: const BoxConstraints.tightFor(width: 170.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45.0),
                  ),
                  elevation: 2.0,
                  fillColor: SolidColors.mainColor,
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    top: 15.0,
                    bottom: 15.0,
                    right: 15.0,
                  ),
                  child: const Text(
                    "0",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                RawMaterialButton(
                  onPressed: clickDot,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: SolidColors.mainColor,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    ".",
                    style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                RawMaterialButton(
                  onPressed: equals,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "=",
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w500,
                      color: SolidColors.mainColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
