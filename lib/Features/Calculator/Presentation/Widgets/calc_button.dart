import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/calculator_bloc.dart';

class CalcButton extends StatelessWidget {
  final String text;
  final Color color;

  const CalcButton({
    super.key,
    required this.text,
    this.color = const Color(0xFF2D2D2E), // Subtle dark grey default
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
          foregroundColor: Colors.white,
          padding: EdgeInsets.zero, // Remove default padding to prevent 2-line wrap
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown, // Shrinks text to fit if it's too wide
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}