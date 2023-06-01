import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_clean_arch/core/error/failures.dart';
import 'package:tdd_clean_arch/core/usecases/usecase.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTriviaUseCase implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTriviaUseCase(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTribia(params.number);
  }
}

class Params extends Equatable {
  final int number;
  const Params({required this.number});
  @override
  List<Object?> get props => [number];
}
