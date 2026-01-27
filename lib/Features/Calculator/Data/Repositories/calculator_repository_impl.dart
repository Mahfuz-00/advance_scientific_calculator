import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:math_expressions/math_expressions.dart';
import '../../Domain/Repositories/calculator_repository.dart';
import '../../../../Core/Error/failures.dart';
import '../../../../Core/Utils/constants.dart';

class CalculatorRepositoryImpl implements CalculatorRepository {
  final FlutterSecureStorage storage;

  CalculatorRepositoryImpl(this.storage);

  @override
  Future<Either<Failure, double>> evaluate(String expression) async {
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveHistory(String entry) async {
    try {
      List<String> history = await getHistory().then((r) => r.getOrElse(() => []));
      history = [entry, ...history]..take(50); // keep last 50
      await storage.write(key: historyKey, value: history.join('␞'));
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getHistory() async {
    try {
      String? data = await storage.read(key: historyKey);
      if (data == null || data.isEmpty) return const Right([]);
      return Right(data.split('␞'));
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}