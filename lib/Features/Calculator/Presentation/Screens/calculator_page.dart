import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/calculator_bloc.dart';
import '../Widgets/calc_button.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen height to calculate proportions
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: const Text('Scientific Calculator',
            style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.w300)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 40, // Reduced height to save space
      ),
      body: Column(
        children: [
          // 1. HISTORY SECTION
          Container(
            height: screenHeight * 0.14, // Slightly reduced to prevent overflow
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 8, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("HISTORY",
                          style: TextStyle(color: Colors.blueGrey, fontSize: 10, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.delete_sweep_outlined, color: Colors.redAccent, size: 18),
                        onPressed: () => context.read<CalculatorBloc>().add(ClearHistory()), // FIXED
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<CalculatorBloc, CalculatorState>(
                    builder: (context, state) {
                      return ListView.builder(
                        reverse: true,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: state.history.length,
                        itemBuilder: (context, i) => Text(
                          state.history[i],
                          textAlign: TextAlign.right,
                          style: const TextStyle(color: Colors.white38, fontSize: 14),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // 2. CALCULATION DISPLAY (This will shrink/grow to fill space)
          Expanded(
            child: BlocBuilder<CalculatorBloc, CalculatorState>(
              builder: (context, state) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Text(
                          state.expression.isEmpty ? ' ' : state.expression,
                          style: const TextStyle(color: Colors.blueAccent, fontSize: 26),
                        ),
                      ),
                      const SizedBox(height: 5),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          state.isLoading ? '...' : state.result,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 54, // Slightly smaller base size to prevent huge jumps
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // 3. KEYPAD SECTION
          Container(
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
            decoration: const BoxDecoration(
              color: Color(0xFF121212),
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: SafeArea( // Ensures buttons don't hit the bottom gesture bar
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min, // Vital for preventing overflow
                children: [
                  // Scientific Row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ['sin', 'cos', 'tan', 'π', 'e', 'sqrt', '^', 'log']
                          .map((text) => _buildSmallButton(text)).toList(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    childAspectRatio: 1.4, // Making buttons wider/shorter to save height
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    children: const [
                      CalcButton(text: 'C', color: Colors.redAccent),
                      CalcButton(text: '(', color: Colors.white12),
                      CalcButton(text: ')', color: Colors.white12),
                      CalcButton(text: '/', color: Colors.blue),
                      CalcButton(text: '7'),
                      CalcButton(text: '8'),
                      CalcButton(text: '9'),
                      CalcButton(text: '*', color: Colors.blue),
                      CalcButton(text: '4'),
                      CalcButton(text: '5'),
                      CalcButton(text: '6'),
                      CalcButton(text: '-', color: Colors.blue),
                      CalcButton(text: '1'),
                      CalcButton(text: '2'),
                      CalcButton(text: '3'),
                      CalcButton(text: '+', color: Colors.blue),
                      CalcButton(text: '.'),
                      CalcButton(text: '0'),
                      CalcButton(text: '⌫', color: Colors.orange),
                      CalcButton(text: '=', color: Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallButton(String label) {
    return Container(
      width: 70,
      height: 40,
      margin: const EdgeInsets.only(right: 6),
      child: CalcButton(text: label, color: const Color(0xFF252525)),
    );
  }
}