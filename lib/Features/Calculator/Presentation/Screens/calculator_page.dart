import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/calculator_bloc.dart';
import '../Widgets/calc_button.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scientific Calculator')),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CalculatorBloc, CalculatorState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        state.expression,
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        state.isLoading ? '...' : state.result,
                        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        itemCount: state.history.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            title: Text(state.history[i], textAlign: TextAlign.right),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          GridView.count(
            crossAxisCount: 5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            children: [
              CalcButton(text: 'sin', color: Colors.grey),
              CalcButton(text: 'cos', color: Colors.grey),
              CalcButton(text: 'tan', color: Colors.grey),
              CalcButton(text: '(', color: Colors.grey),
              CalcButton(text: ')', color: Colors.grey),

              CalcButton(text: '7'),
              CalcButton(text: '8'),
              CalcButton(text: '9'),
              CalcButton(text: '/'),
              CalcButton(text: 'C', color: Colors.red),

              CalcButton(text: '4'),
              CalcButton(text: '5'),
              CalcButton(text: '6'),
              CalcButton(text: '*'),
              CalcButton(text: '⌫', color: Colors.orange),

              CalcButton(text: '1'),
              CalcButton(text: '2'),
              CalcButton(text: '3'),
              CalcButton(text: '-'),
              Expanded(flex: 2, child: CalcButton(text: '=', color: Colors.blue)),

              Expanded(flex: 2, child: CalcButton(text: '0')),
              CalcButton(text: '.'),
              CalcButton(text: '+'),
            ],
          ),
        ],
      ),
    );
  }
}