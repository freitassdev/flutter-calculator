import 'package:flutter/material.dart';
import 'package:dart_eval/dart_eval.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String _output = '0';
  double _firstNumber = 0;
  String _operation = '';

  void calculate(String key) {
    switch (key) {
      case 'AC':
        setState(() => _output = '0');
        break;
      case 'DEL':
        setState(() => _output = _output.substring(0, _output.length - 1));
        break;
      case '=':
        _output = _output.replaceAll(',', '.');
        _output = _output.replaceAll('X', '*');

        dynamic result = eval(_output);
        setState(() {
          _output = result.toString();
          _output = _output.replaceAll('.', ',');
        });
        break;
      default:
        if (_output.endsWith('-') && key == '-' ||
            _output.endsWith('+') && key == '+' ||
            _output.endsWith('X') && key == 'X' ||
            _output.endsWith('/') && key == '/') return;
        if (_output == '0' && key == ',' ||
            _output == '0' && key == '-' ||
            _output == '0' && key == '+' ||
            _output == '0' && key == 'X' ||
            _output == '0' && key == '/') return;
        if (_output == '0') {
          setState(() => _output = key);
        } else {
          setState(() => _output += key);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          margin: const EdgeInsets.only(top: 150),
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _output,
                    style: const TextStyle(fontSize: 72, color: Colors.white),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CalculatorItem(
                    label: 'AC',
                    onTap: () => calculate('AC'),
                    color: Colors.grey[500],
                  ),
                  const CalculatorItem(
                    label: ' ',
                    color: Colors.black,
                  ),
                  const CalculatorItem(
                    label: ' ',
                    color: Colors.black,
                  ),
                  CalculatorItem(
                    label: 'DEL',
                    onTap: () => calculate('DEL'),
                    color: Colors.grey[500],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CalculatorItem(
                    label: '7',
                    onTap: () => calculate('7'),
                  ),
                  CalculatorItem(
                    label: '8',
                    onTap: () => calculate('8'),
                  ),
                  CalculatorItem(
                    label: '9',
                    onTap: () => calculate('9'),
                  ),
                  CalculatorItem(
                    label: '/',
                    onTap: () => calculate('/'),
                    color: Colors.yellow[800],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CalculatorItem(
                    label: '4',
                    onTap: () => calculate('4'),
                  ),
                  CalculatorItem(
                    label: '5',
                    onTap: () => calculate('5'),
                  ),
                  CalculatorItem(
                    label: '6',
                    onTap: () => calculate('6'),
                  ),
                  CalculatorItem(
                    label: 'X',
                    onTap: () => calculate('X'),
                    color: Colors.yellow[800],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CalculatorItem(
                    label: '1',
                    onTap: () => calculate('1'),
                  ),
                  CalculatorItem(
                    label: '2',
                    onTap: () => calculate('2'),
                  ),
                  CalculatorItem(
                    label: '3',
                    onTap: () => calculate('3'),
                  ),
                  CalculatorItem(
                    label: '-',
                    onTap: () => calculate('-'),
                    color: Colors.yellow[800],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CalculatorItem(
                    label: '0',
                    onTap: () => calculate('0'),
                  ),
                  CalculatorItem(
                    label: ',',
                    onTap: () => calculate(','),
                  ),
                  CalculatorItem(
                    label: '=',
                    onTap: () => calculate('='),
                  ),
                  CalculatorItem(
                    label: '+',
                    onTap: () => calculate('+'),
                    color: Colors.yellow[800],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalculatorItem extends StatelessWidget {
  final String label;
  final Color? color;
  final Function()? onTap;
  const CalculatorItem({
    super.key,
    this.label = "",
    this.onTap,
    this.color = const Color.fromRGBO(33, 33, 33, 1),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
