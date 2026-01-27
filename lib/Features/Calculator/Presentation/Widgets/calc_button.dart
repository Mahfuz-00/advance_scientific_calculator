import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/calculator_bloc.dart';

class CalcButton extends StatelessWidget {
  final String text;
  final Color color;

  const CalcButton({
    super.key,
    required this.text,
    this.color = Colors.blueGrey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: ElevatedButton(
        onPressed: () {
          final bloc = context.read<CalculatorBloc>();

          if (text == '=') {
            bloc.add(Calculate());
          } else if (text == 'C') {
            bloc.add(Clear());
          } else if (text == '⌫') {
            bloc.add(Backspace());
          } else {
            bloc.add(AppendCharacter(text));
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(text, style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}