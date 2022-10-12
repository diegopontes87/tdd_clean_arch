import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_clean_arch/core/error/failures.dart';
import 'package:tdd_clean_arch/core/usecases/no_params.dart';
import 'package:tdd_clean_arch/core/util/input_converter.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';
const String inputFailureMessage = 'Input Failure - The number must be a positive or zero';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  GetConcreteNumberTriviaUseCase? getConcreteNumberTriviaUseCase;
  GetRandomNumberTriviaUseCase? getRandomNumberTriviaUseCase;
  InputConverter? inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTriviaUseCase,
    required this.getRandomNumberTriviaUseCase,
    required this.inputConverter,
  }) : super(EmptyState()) {
    on<NumberTriviaEvent>((event, emit) async {
      if (event is GetTriviaForConcreteNumberEvent) {
        final inputEither = inputConverter?.stringToUnsignedInteger(event.numberString);
        inputEither?.fold((failure) {
          emit(const ErrorState(errorMessage: inputFailureMessage));
        }, (integer) async* {
          emit(LoadingState());
          final failureOrTrivia = await getConcreteNumberTriviaUseCase!(Params(number: integer));
          yield* _eitherLoadedOrErrorState(failureOrTrivia);
        });
      } else if (event is GetTriviaForRandomNumberEvent) {
        emit(LoadingState());
        final failureOrTrivia = await getRandomNumberTriviaUseCase!(NoParams());
        _eitherLoadedOrErrorState(failureOrTrivia);
      }
    });
  }

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(
    Either<Failure, NumberTrivia> failureOrTrivia,
  ) async* {
    yield failureOrTrivia.fold(
      (failure) => ErrorState(
        errorMessage: _mapFailureToMessage(failure),
      ),
      (trivia) => LoadedState(trivia),
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
