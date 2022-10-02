import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTribia(int number);
  Future<NumberTriviaModel> getRambomNumberTribia();
}
