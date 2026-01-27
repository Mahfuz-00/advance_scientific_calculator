import 'package:dartz/dartz.dart';
import '../../../../Core/Error/failures.dart';
import '../Repositories/calculator_repository.dart';

class GetHistory {
  final CalculatorRepository repository;
  GetHistory(this.repository);

  Future<Either<Failure, List<String>>> call() {
    return repository.getHistory();
  }
}