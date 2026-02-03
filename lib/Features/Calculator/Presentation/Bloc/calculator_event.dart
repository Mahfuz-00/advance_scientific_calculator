part of 'calculator_bloc.dart';

abstract class CalculatorEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppendCharacter extends CalculatorEvent {
  final String char;
  AppendCharacter(this.char);
  @override
  List<Object> get props => [char];
}

class Clear extends CalculatorEvent {}

class Backspace extends CalculatorEvent {}

class Calculate extends CalculatorEvent {}

class LoadHistory extends CalculatorEvent {}

class ClearHistory extends CalculatorEvent {}
