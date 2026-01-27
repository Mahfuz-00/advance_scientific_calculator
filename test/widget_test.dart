import 'package:advance_scientific_calculator/Features/Calculator/Presentation/Screens/calculator_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:advance_scientific_calculator/Core/Injection/injection_container.dart' as di;
import 'package:advance_scientific_calculator/Features/Calculator/Presentation/Bloc/calculator_bloc.dart';
import 'package:advance_scientific_calculator/Features/Calculator/Presentation/Widgets/calc_button.dart';

void main() {
  setUpAll(() async {
    await di.init();
  });

  testWidgets('Calculator page loads correctly', (WidgetTester tester) async {
    final bloc = di.sl<CalculatorBloc>();

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: bloc,
          child: const CalculatorPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Page title must exist
    expect(find.text('Scientific Calculator'), findsOneWidget);

    // At least some buttons must exist
    expect(find.byType(CalcButton), findsAtLeastNWidgets(10));

    // App should not crash and page should render
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
