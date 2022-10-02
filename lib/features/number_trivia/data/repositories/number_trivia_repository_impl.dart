import 'package:tdd_clean_arch/core/platform/network_info.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_arch/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImplementation implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImplementation({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTribia(int number) {
    // TODO: implement getConcreteNumberTribia
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRambomNumberTribia() {
    // TODO: implement getRambomNumberTribia
    throw UnimplementedError();
  }
}
