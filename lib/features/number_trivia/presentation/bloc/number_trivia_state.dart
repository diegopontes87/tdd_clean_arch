import 'package:equatable/equatable.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

class EmptyState extends NumberTriviaState {}

class LoadingState extends NumberTriviaState {}

class LoadedState extends NumberTriviaState {
  final NumberTrivia numberTrivia;

  const LoadedState(this.numberTrivia);

  @override
  List<Object> get props => super.props..addAll([numberTrivia]);
}

class ErrorState extends NumberTriviaState {
  final String errorMessage;

  const ErrorState({required this.errorMessage});

  @override
  List<Object> get props => super.props..addAll([errorMessage]);
}
