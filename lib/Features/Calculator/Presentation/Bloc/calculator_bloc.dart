import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Domain/Usecases/evaluate_expression.dart';
import '../../Domain/Usecases/save_to_history.dart';
import '../../Domain/Usecases/get_history.dart';
import '../../Domain/Usecases/delete_history.dart'; // New import

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  final EvaluateExpression evaluate;
  final SaveToHistory saveHistory;
  final GetHistory getHistory;
  final DeleteHistory deleteHistory; // Added

  CalculatorBloc({
    required this.evaluate,
    required this.saveHistory,
    required this.getHistory,
    required this.deleteHistory,
  }) : super(const CalculatorState()) {
    on<AppendCharacter>(_onAppend);
    on<Clear>(_onClear);
    on<Backspace>(_onBackspace);
    on<Calculate>(_onCalculate);
    on<LoadHistory>(_onLoadHistory);
    on<ClearHistory>(_onClearHistory); // Added

    add(LoadHistory());
  }

  void _onAppend(AppendCharacter event, Emitter emit) {
    String char = event.char;
    // Scientific shortcuts for cleaner math parsing
    if (char == 'π') char = '3.14159265';
    if (char == 'e') char = '2.71828182';

    emit(state.copyWith(expression: state.expression + char));
  }

  void _onClear(Clear event, Emitter emit) {
    emit(state.copyWith(expression: '', result: ''));
  }

  void _onBackspace(Backspace event, Emitter emit) {
    if (state.expression.isNotEmpty) {
      emit(state.copyWith(
        expression: state.expression.substring(0, state.expression.length - 1),
      ));
    }
  }

  Future<void> _onCalculate(Calculate event, Emitter emit) async {
    if (state.expression.isEmpty) return;
    emit(state.copyWith(isLoading: true));

    final resultEither = await evaluate(state.expression);

    await resultEither.fold(
          (failure) async => emit(state.copyWith(result: 'Error', isLoading: false)),
          (value) async {
        final disp = value.toStringAsFixed(value % 1 == 0 ? 0 : 4);
        emit(state.copyWith(result: disp, isLoading: false));
        await saveHistory('${state.expression} = $disp');
        add(LoadHistory());
      },
    );
  }

  Future<void> _onLoadHistory(LoadHistory event, Emitter emit) async {
    final historyEither = await getHistory();
    historyEither.fold((_) {}, (list) => emit(state.copyWith(history: list)));
  }

  Future<void> _onClearHistory(ClearHistory event, Emitter emit) async {
    final result = await deleteHistory();
    result.fold((_) {}, (_) => emit(state.copyWith(history: [])));
  }
}