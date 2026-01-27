import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Features/Calculator/Presentation/Bloc/calculator_bloc.dart';
import 'Features/Calculator/Presentation/Screens/calculator_page.dart';
import 'Core/Injection/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<CalculatorBloc>(),
      child: MaterialApp(
        title: 'Scientific Calculator',
        theme: ThemeData.dark(useMaterial3: true),
        home: const CalculatorPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}