import 'package:dartz/dartz.dart';
import '../../../../Core/Error/failures.dart';
import '../Repositories/calculator_repository.dart';

class DeleteHistory {
  final CalculatorRepository repository;
  DeleteHistory(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.deleteHistory();
  }
}