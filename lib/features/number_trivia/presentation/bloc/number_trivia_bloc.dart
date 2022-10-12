import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd_clean_arch/core/error/failures.dart';
import 'package:tdd_clean_arch/core/usecases/no_params.dart';
import 'package:tdd_clean_arch/core/util/input_converter.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:tdd_clean_arch/features/number_trivia/presentation/bloc/bloc.dart';

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
        var inputEither = inputConverter?.stringToUnsignedInteger(event.numberString);
        inputEither?.fold((failure) {
          emit(const ErrorState(errorMessage: inputFailureMessage));
        }, (integer) async {
          emit(LoadingState());
          final failureOrTrivia = await getConcreteNumberTriviaUseCase!(Params(number: integer));
          _eitherLoadedOrErrorState(failureOrTrivia);
        });
      } else if (event is GetTriviaForRandomNumberEvent) {
        emit(LoadingState());
        final failureOrTrivia = await getRandomNumberTriviaUseCase!(NoParams());
        _eitherLoadedOrErrorState(failureOrTrivia);
      }
    });
  }

  void _eitherLoadedOrErrorState(
    Either<Failure, NumberTrivia> failureOrTrivia,
  ) async {
    failureOrTrivia.fold(
      (failure) async {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(ErrorState(errorMessage: _mapFailureToMessage(failure)));
      },
      (trivia) async {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(LoadedState(trivia));
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
