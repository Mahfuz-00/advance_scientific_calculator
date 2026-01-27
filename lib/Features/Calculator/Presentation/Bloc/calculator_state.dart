part of 'calculator_bloc.dart';

class CalculatorState extends Equatable {
  final String expression;
  final String result;
  final List<String> history;
  final bool isLoading;

  const CalculatorState({
    this.expression = '',
    this.result = '',
    this.history = const [],
    this.isLoading = false,
  });

  CalculatorState copyWith({
    String? expression,
    String? result,
    List<String>? history,
    bool? isLoading,
  }) {
    return CalculatorState(
      expression: expression ?? this.expression,
      result: result ?? this.result,
      history: history ?? this.history,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [expression, result, history, isLoading];
}
