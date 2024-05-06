import 'dart:math';

import 'package:dart_eval/dart_eval.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/services.dart';

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
  double _outputFontSize = 72;
  Color _outputColor = Colors.white;
  void calculate(String key) {
    switch (key) {
      case 'AC':
        setState(() {
          _output = '0';
          _outputColor = Colors.white;
        });
        break;
      case 'DEL':
        setState(() {
          _outputColor = Colors.white;
          if (_output.length > 1) {
            _output = _output.substring(0, _output.length - 1);
          } else {
            _output = '0';
          }
        });
        break;
      case '=':
        _output = _output.replaceAll(',', '.');
        _output = _output.replaceAll('X', '*');

        try {
          dynamic result = eval(_output);
          setState(() {
            _output = result.toString();
            _output = _output.replaceAll('.', ',');
          });
        } catch (e) {
          setState(() {
            _outputColor = Colors.red;
            _output = _output.replaceAll('.', ',');
          });
        }
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
        } else if (_output.length < 22) {
          setState(() => _output += key);
        }
        setState(() => _outputColor = Colors.white);

        break;
    }
    if (_output.length == 7) {
      setState(() => _outputFontSize = 55);
    } else if (_output.length == 10) {
      setState(() => _outputFontSize = 40);
    } else if (_output.length > 14) {
      setState(() => _outputFontSize = 30);
    } else if (_output.length < 7) {
      setState(() => _outputFontSize = 72);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 150),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _output
                        .replaceAll('X', '×')
                        .replaceAll('/', '÷')
                        .replaceAll('*', '×')
                        .substring(0, min(_output.length, 22)),
                    style: TextStyle(
                      fontSize: _outputFontSize,
                      color: _outputColor,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.all(10),
              height: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
                        icon: LucideIcons.divide,
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
                        icon: Icons.close,
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
                        icon: LucideIcons.minus,
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
                        icon: LucideIcons.equal,
                        label: '=',
                        onTap: () => calculate('='),
                      ),
                      CalculatorItem(
                        icon: LucideIcons.plus,
                        label: '+',
                        onTap: () => calculate('+'),
                        color: Colors.yellow[800],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalculatorItem extends StatefulWidget {
  final String label;
  final Color? color;
  final Function()? onTap;
  final IconData? icon;
  const CalculatorItem({
    super.key,
    this.label = "",
    this.onTap,
    this.color = const Color.fromRGBO(33, 33, 33, 1),
    this.icon,
  });

  @override
  State<CalculatorItem> createState() => _CalculatorItemState();
}

class _CalculatorItemState extends State<CalculatorItem> {
  // Color _currentColor = Colors.transparent;

  // @override
  // void initState() {
  //   super.initState();
  //   _currentColor = widget.color ?? const Color.fromRGBO(33, 33, 33, 1);
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(
            50), // Define o mesmo raio de borda para o InkWell
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              50), // Define o mesmo raio de borda para a animação Ink
        ),
        onTap: () {
          HapticFeedback.mediumImpact();
          if (widget.onTap != null) widget.onTap!();
        },
        child: Ink(
          decoration: BoxDecoration(
            color: widget.color ?? const Color.fromRGBO(33, 33, 33, 1),
            borderRadius: BorderRadius.circular(50),
          ),
          child: SizedBox(
            width: 80,
            height: 80,
            child: Center(
              child: widget.icon != null
                  ? Icon(
                      widget.icon,
                      size: 30,
                      color: Colors.white,
                    )
                  : Text(
                      widget.label,
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
