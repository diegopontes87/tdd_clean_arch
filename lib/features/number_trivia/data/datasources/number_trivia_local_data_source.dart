import 'package:tdd_clean_arch/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTriva(NumberTriviaModel triviaToCache);
}
