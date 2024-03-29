import 'package:dartz/dartz.dart';
import 'package:tdd_clean_arch/core/error/failures.dart';
import 'package:tdd_clean_arch/core/usecases/no_params.dart';
import 'package:tdd_clean_arch/core/usecases/usecase.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTriviaUseCase implements UseCase<NumberTrivia, NoParams> {
  NumberTriviaRepository repository;

  GetRandomNumberTriviaUseCase(this.repository);
  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRambomNumberTribia();
  }
}
