import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_clean_arch/core/error/failures.dart';
import 'package:tdd_clean_arch/core/usecases/usecase.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);
  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRambomNumberTribia();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
