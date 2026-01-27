import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Domain/Usecases/evaluate_expression.dart';
import '../../Domain/Usecases/save_to_history.dart';
import '../../Domain/Usecases/get_history.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  final EvaluateExpression evaluate;
  final SaveToHistory saveHistory;
  final GetHistory getHistory;

  CalculatorBloc({
    required this.evaluate,
    required this.saveHistory,
    required this.getHistory,
  }) : super(const CalculatorState()) {
    on<AppendCharacter>(_onAppend);
    on<Clear>(_onClear);
    on<Backspace>(_onBackspace);
    on<Calculate>(_onCalculate);
    on<LoadHistory>(_onLoadHistory);

    add(LoadHistory());
  }

  void _onAppend(AppendCharacter event, Emitter emit) {
    emit(state.copyWith(expression: state.expression + event.char));
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
          (failure) async {
        emit(state.copyWith(result: 'Error', isLoading: false));
      },
          (value) async {
        final disp = value.toStringAsFixed(value % 1 == 0 ? 0 : 4);
        emit(state.copyWith(result: disp, isLoading: false));

        final entry = '${state.expression} = $disp';
        await saveHistory(entry);
        add(LoadHistory());
      },
    );
  }

  Future<void> _onLoadHistory(LoadHistory event, Emitter emit) async {
    final historyEither = await getHistory();
    historyEither.fold(
          (_) {},
          (list) => emit(state.copyWith(history: list)),
    );
  }
}
