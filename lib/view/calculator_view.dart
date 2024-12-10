import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  List<String> lstSymbols = [
    "C",
    "/",
    "*",
    "<-",
    "7",
    "8",
    "9",
    "-",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "=",
    "0",
    ".",
  ];

  String input = "";
  double? firstOperand;
  String? operator;

  void _buttonPressed(String symbol) {
    setState(() {
      if (symbol == "C") {
        input = "";
        firstOperand = null;
        operator = null;
      } else if (symbol == "<-") {
        input = input.isNotEmpty ? input.substring(0, input.length - 1) : "";
      } else if (symbol == "=") {
        if (firstOperand != null && operator != null && input.isNotEmpty) {
          double secondOperand = double.tryParse(input) ?? 0;
          switch (operator) {
            case "+":
              input = (firstOperand! + secondOperand).toString();
              break;
            case "-":
              input = (firstOperand! - secondOperand).toString();
              break;
            case "*":
              input = (firstOperand! * secondOperand).toString();
              break;
            case "/":
              if (secondOperand != 0) {
                input = (firstOperand! / secondOperand).toString();
              } else {
                input = "Error";
              }
              break;
          }
          firstOperand = null;
          operator = null;
        }
      } else if (["+", "-", "*", "/"].contains(symbol)) {
        if (input.isNotEmpty) {
          firstOperand = double.tryParse(input);
          operator = symbol;
          input = "";
        }
      } else {
        input += symbol;
      }
      _textController.text = input;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              textDirection: TextDirection.rtl,
              controller: _textController,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: lstSymbols.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: () => _buttonPressed(lstSymbols[index]),
                    child: Text(
                      lstSymbols[index],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
