import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean_arch/core/error/failures.dart';
import 'package:tdd_clean_arch/core/usecases/no_params.dart';
import 'package:tdd_clean_arch/core/util/input_converter.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:tdd_clean_arch/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetRandomNumberTriviaUseCase>(),
  MockSpec<GetConcreteNumberTriviaUseCase>(),
  MockSpec<InputConverter>(),
])
@Timeout(Duration(seconds: 45))
void main() {
  NumberTriviaBloc? bloc;
  MockGetConcreteNumberTriviaUseCase? mockGetConcreteNumberTriviaUC;
  MockGetRandomNumberTriviaUseCase? mockGetRandomNumberTriviaUC;
  MockInputConverter? mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTriviaUC = MockGetConcreteNumberTriviaUseCase();
    mockGetRandomNumberTriviaUC = MockGetRandomNumberTriviaUseCase();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      getConcreteNumberTriviaUseCase: mockGetConcreteNumberTriviaUC,
      getRandomNumberTriviaUseCase: mockGetRandomNumberTriviaUC,
      inputConverter: mockInputConverter,
    );
  });

  test('Initial state should be EmptyState', () {
    expect(bloc?.state, EmptyState());
  });

  group('GetTriviaForConcreteNumber', () {
    const numberString = '1';
    const numberInteger = 1;
    const numberTrivia = NumberTrivia(number: 1, text: 'text test');
    void setupMockInputConverterSuccess() {
      when(mockInputConverter?.stringToUnsignedInteger(numberString)).thenReturn(const Right(numberInteger));
    }

    test('Should call the inputConverter to validate and convert the string to an unsigned integer', () async {
      setupMockInputConverterSuccess();
      bloc?.add(const GetTriviaForConcreteNumberEvent(numberString: numberString));
      await untilCalled(mockInputConverter?.stringToUnsignedInteger(numberString));
      verify(mockInputConverter?.stringToUnsignedInteger(numberString));
    });

    test('Should emit [Error] when the input is invalid', () async* {
      when(mockInputConverter?.stringToUnsignedInteger(numberString)).thenReturn(Left(InvalidInputFailure()));
      final expected = [
        EmptyState(),
        const ErrorState(errorMessage: inputFailureMessage),
      ];
      expectLater(bloc?.state, emitsInOrder(expected));
      bloc?.add(const GetTriviaForConcreteNumberEvent(numberString: numberString));
    });

    test('Should get data from the concrete usecase', () async* {
      setupMockInputConverterSuccess();
      when(mockGetConcreteNumberTriviaUC!(any)).thenAnswer((_) async => const Right(numberTrivia));

      bloc?.add(const GetTriviaForConcreteNumberEvent(numberString: numberString));
      await untilCalled(mockGetConcreteNumberTriviaUC!(any));

      verify(mockGetConcreteNumberTriviaUC!(const Params(number: numberInteger)));
    });

    test('Should emit [LoadingState, LoadedState] when data is gotten successfully', () async* {
      setupMockInputConverterSuccess();
      when(mockGetConcreteNumberTriviaUC!(any)).thenAnswer((_) async => const Right(numberTrivia));
      final expected = [
        EmptyState(),
        LoadingState(),
        const LoadedState(numberTrivia),
      ];

      expectLater(bloc?.state, emitsInOrder(expected));
      bloc?.add(const GetTriviaForConcreteNumberEvent(numberString: numberString));
    });

    test('Should emit [LoadingState, ErrorState] when data fails', () async* {
      setupMockInputConverterSuccess();
      when(mockGetConcreteNumberTriviaUC!(any)).thenAnswer((_) async => Left(ServerFailure()));
      final expected = [
        EmptyState(),
        LoadingState(),
        const ErrorState(errorMessage: serverFailureMessage),
      ];

      expectLater(bloc?.state, emitsInOrder(expected));
      bloc?.add(const GetTriviaForConcreteNumberEvent(numberString: numberString));
    });

    test('Should emit [LoadingState, ErrorState] with proper message for the error when getting data fails', () async* {
      setupMockInputConverterSuccess();
      when(mockGetConcreteNumberTriviaUC!(any)).thenAnswer((_) async => Left(CacheFailure()));
      final expected = [
        EmptyState(),
        LoadingState(),
        const ErrorState(errorMessage: cacheFailureMessage),
      ];

      expectLater(bloc?.state, emitsInOrder(expected));
      bloc?.add(const GetTriviaForConcreteNumberEvent(numberString: numberString));
    });
  });

  group('GetTriviaForRandomNumber', () {
    const numberTrivia = NumberTrivia(number: 1, text: 'text test');

    test('Should get data from the concrete usecase', () async* {
      when(mockGetRandomNumberTriviaUC!(any)).thenAnswer((_) async => const Right(numberTrivia));

      bloc?.add(GetTriviaForRandomNumberEvent());
      await untilCalled(mockGetConcreteNumberTriviaUC!(any));

      verify(mockGetRandomNumberTriviaUC!(NoParams()));
    });

    test('Should emit [LoadingState, LoadedState] when data is gotten successfully', () async* {
      when(mockGetConcreteNumberTriviaUC!(any)).thenAnswer((_) async => const Right(numberTrivia));
      final expected = [
        EmptyState(),
        LoadingState(),
        const LoadedState(numberTrivia),
      ];

      expectLater(bloc?.state, emitsInOrder(expected));
      bloc?.add(GetTriviaForRandomNumberEvent());
    });

    test('Should emit [LoadingState, ErrorState] when data fails', () async* {
      when(mockGetConcreteNumberTriviaUC!(any)).thenAnswer((_) async => Left(ServerFailure()));
      final expected = [
        EmptyState(),
        LoadingState(),
        const ErrorState(errorMessage: serverFailureMessage),
      ];

      expectLater(bloc?.state, emitsInOrder(expected));
      bloc?.add(GetTriviaForRandomNumberEvent());
    });

    test('Should emit [LoadingState, ErrorState] with proper message for the error when getting data fails', () async* {
      when(mockGetConcreteNumberTriviaUC!(any)).thenAnswer((_) async => Left(CacheFailure()));
      final expected = [
        EmptyState(),
        LoadingState(),
        const ErrorState(errorMessage: cacheFailureMessage),
      ];

      expectLater(bloc?.state, emitsInOrder(expected));
      bloc?.add(GetTriviaForRandomNumberEvent());
    });
  });
}
