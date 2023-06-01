part of 'number_trivia_cubit.dart';

enum NumberTriviaStatus {
  initialState,
  loadingState,
  loadedState,
  errorState,
}

class NumberTriviaState extends Equatable {
  const NumberTriviaState({
    this.status,
    this.numberTrivia,
    this.errorMessage,
  });

  final String? errorMessage;
  final NumberTrivia? numberTrivia;
  final NumberTriviaStatus? status;

  factory NumberTriviaState.initial() {
    return const NumberTriviaState(
      errorMessage: '',
      numberTrivia: NumberTrivia(
        text: '',
        number: 0,
      ),
      status: NumberTriviaStatus.initialState,
    );
  }

  NumberTriviaState copyWith({
    String? errorMessage,
    NumberTrivia? numberTrivia,
    NumberTriviaStatus? status,
  }) =>
      NumberTriviaState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        numberTrivia: numberTrivia ?? this.numberTrivia,
      );

  @override
  List<Object?> get props => [
        status,
        numberTrivia,
        errorMessage,
      ];
}
