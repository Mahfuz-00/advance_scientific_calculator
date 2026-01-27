import 'package:dartz/dartz.dart';
import '../Repositories/calculator_repository.dart';
import '../../../../Core/Error/failures.dart';

class SaveToHistory {
  final CalculatorRepository repository;
  SaveToHistory(this.repository);

  Future<Either<Failure, void>> call(String entry) {
    return repository.saveHistory(entry);
  }
}