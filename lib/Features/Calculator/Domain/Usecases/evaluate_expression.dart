import 'package:dartz/dartz.dart';
import '../Repositories/calculator_repository.dart';
import '../../../../Core/Error/failures.dart';

class EvaluateExpression {
  final CalculatorRepository repository;
  EvaluateExpression(this.repository);

  Future<Either<Failure, double>> call(String expression) {
    return repository.evaluate(expression);
  }
}