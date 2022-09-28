import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

import 'get_concrete_number_trivia_test.mocks.dart';

@GenerateNiceMocks([MockSpec<NumberTriviaRepository>()])
void main() {
  GetConcreteNumberTrivia? usecase;

  MockNumberTriviaRepository? mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository!);
  });
  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(number: 1, text: 'test');
  test('Should get trivia for the number from the repository', () async {
    when(mockNumberTriviaRepository?.getConcreteNumberTribia(any)).thenAnswer((_) async => const Right(tNumberTrivia));
    final result = await usecase!(number: tNumber);
    expect(result, const Right(tNumberTrivia));
    verify(mockNumberTriviaRepository?.getConcreteNumberTribia(tNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
