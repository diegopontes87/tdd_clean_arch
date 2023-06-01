import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_clean_arch/features/number_trivia/presentation/widgets/trivia_controls.dart';

import '../../../../injection_container.dart';
import '../bloc/cubit/number_trivia_cubit.dart';
import '../widgets/loading_widget.dart';
import '../widgets/message_display.dart';
import '../widgets/trivia_display.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (_) => getIt<NumberTriviaCubit>(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  BlocBuilder<NumberTriviaCubit, NumberTriviaState>(
                    builder: (_, state) {
                      switch (state.status) {
                        case NumberTriviaStatus.initialState:
                          return const MessageDisplay(message: 'Start searching!');
                        case NumberTriviaStatus.loadingState:
                          return const LoadingWidget();
                        case NumberTriviaStatus.loadedState:
                          return TriviaDisplay(numberTrivia: state.numberTrivia);
                        case NumberTriviaStatus.errorState:
                          return MessageDisplay(message: state.errorMessage);
                        default:
                          return const MessageDisplay(message: 'Start searching!');
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  const TriviaControls()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
