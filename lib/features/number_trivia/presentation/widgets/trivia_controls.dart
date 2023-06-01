import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_clean_arch/features/number_trivia/presentation/bloc/cubit/number_trivia_cubit.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key? key,
  }) : super(key: key);

  @override
  TriviaControlsState createState() => TriviaControlsState();
}

class TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  String number = '0';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberTriviaCubit, NumberTriviaState>(
      builder: (context, state) {
        return Column(
          children: <Widget>[
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Input a number',
              ),
              onChanged: (value) {
                number = value;
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context.read<NumberTriviaCubit>().getConcreteNumberTrivia(number: int.parse(number)),
                    child: const Text('Search'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context.read<NumberTriviaCubit>().getRandomNumberTrivia(),
                    child: const Text('Get random trivia'),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
