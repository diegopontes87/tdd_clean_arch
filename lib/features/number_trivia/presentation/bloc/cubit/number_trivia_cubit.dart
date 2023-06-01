import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/no_params.dart';
import '../../../../../core/util/input_converter.dart';
import '../../../domain/entities/number_trivia.dart';
import '../../../domain/usecases/get_concrete_number_trivia.dart';
import '../../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';
const String inputFailureMessage = 'Input Failure - The number must be a positive or zero';

class NumberTriviaCubit extends Cubit<NumberTriviaState> {
  InputConverter? inputConverter;
  final GetConcreteNumberTriviaUseCase? _getConcreteNumberTriviaUseCase;
  final GetRandomNumberTriviaUseCase? _getRandomNumberTriviaUseCase;

  NumberTriviaCubit({
    required this.inputConverter,
    required GetConcreteNumberTriviaUseCase getConcreteNumberTriviaUseCase,
    required GetRandomNumberTriviaUseCase getRandomNumberTriviaUseCase,
  })  : _getConcreteNumberTriviaUseCase = getConcreteNumberTriviaUseCase,
        _getRandomNumberTriviaUseCase = getRandomNumberTriviaUseCase,
        super(NumberTriviaState.initial());

  Future getConcreteNumberTrivia({required int? number}) async {
    if (number == null) {
      _mapFailureToMessage(NullFailure());
    } else {
      emit(
        const NumberTriviaState(
          status: NumberTriviaStatus.loadingState,
        ),
      );
      final failureOrTrivia = await _getConcreteNumberTriviaUseCase!(Params(number: number));
      _eitherLoadedOrErrorState(failureOrTrivia);
    }
  }

  Future<void> getRandomNumberTrivia() async {
    emit(
      const NumberTriviaState(
        status: NumberTriviaStatus.loadingState,
      ),
    );
    final failureOrTrivia = await _getRandomNumberTriviaUseCase!(NoParams());
    _eitherLoadedOrErrorState(failureOrTrivia);
  }

  void _eitherLoadedOrErrorState(Either<Failure, NumberTrivia> failureOrTrivia) async {
    failureOrTrivia.fold(
      (failure) async {
        emit(
          NumberTriviaState(
            errorMessage: _mapFailureToMessage(failure),
          ),
        );
      },
      (trivia) async {
        emit(
          NumberTriviaState(
            numberTrivia: trivia,
            status: NumberTriviaStatus.loadedState,
          ),
        );
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return 'Unexpected error';
    }
  }
}
