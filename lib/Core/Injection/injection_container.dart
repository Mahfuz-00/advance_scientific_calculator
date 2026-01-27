import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../Features/Calculator/Data/Repositories/calculator_repository_impl.dart';
import '../../Features/Calculator/Domain/Repositories/calculator_repository.dart';
import '../../Features/Calculator/Domain/Usecases/evaluate_expression.dart';
import '../../Features/Calculator/Domain/Usecases/get_history.dart';
import '../../Features/Calculator/Domain/Usecases/save_to_history.dart';
import '../../Features/Calculator/Presentation/Bloc/calculator_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // Storage
  sl.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());

  // Repository
  sl.registerLazySingleton<CalculatorRepository>(
        () => CalculatorRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => EvaluateExpression(sl()));
  sl.registerLazySingleton(() => SaveToHistory(sl()));
  sl.registerLazySingleton(() => GetHistory(sl()));

  // Bloc
  sl.registerFactory(
        () => CalculatorBloc(
      evaluate: sl(),
      saveHistory: sl(),
      getHistory: sl(),
    ),
  );
}