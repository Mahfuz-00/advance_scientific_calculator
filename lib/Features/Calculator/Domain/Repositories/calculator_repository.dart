import 'package:dartz/dartz.dart';
import '../../../../Core/Error/failures.dart';

abstract class CalculatorRepository {
  Future<Either<Failure, double>> evaluate(String expression);
  Future<Either<Failure, void>> saveHistory(String entry);
  Future<Either<Failure, List<String>>> getHistory();
}