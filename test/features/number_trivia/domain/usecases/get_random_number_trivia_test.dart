import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean_arch/core/usecases/no_params.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'get_concrete_number_trivia_test.mocks.dart';

@GenerateNiceMocks([MockSpec<NumberTriviaRepository>()])
void main() {
  GetRandomNumberTrivia? usecase;
  MockNumberTriviaRepository? mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository!);
  });
  const tNumberTrivia = NumberTrivia(number: 1, text: 'test');
  test('Should get trivia from the repository', () async {
    when(mockNumberTriviaRepository?.getRambomNumberTribia()).thenAnswer((_) async => const Right(tNumberTrivia));
    final result = await usecase!(NoParams());
    expect(result, const Right(tNumberTrivia));
    verify(mockNumberTriviaRepository?.getRambomNumberTribia());
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
