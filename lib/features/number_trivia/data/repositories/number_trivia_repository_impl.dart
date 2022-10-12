import 'package:tdd_clean_arch/core/error/exceptions.dart';
import 'package:tdd_clean_arch/core/network/network_info.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_arch/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart';

typedef _ConcreteOrRandomChooser = Future<NumberTrivia> Function();

class NumberTriviaRepositoryImplementation implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource? remoteDataSource;
  final NumberTriviaLocalDataSource? localDataSource;
  final NetworkInfo? networkInfo;

  NumberTriviaRepositoryImplementation({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTribia(int number) async {
    return await _getTrivia(() async {
      return await remoteDataSource?.getConcreteNumberTribia(number) as NumberTrivia;
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRambomNumberTribia() async {
    return await _getTrivia(() async {
      return await remoteDataSource?.getRambomNumberTribia() as NumberTrivia;
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(_ConcreteOrRandomChooser getConcreteOrRandom) async {
    var isConnected = await networkInfo?.isConnected;
    if (isConnected!) {
      try {
        var numberTrivia = await getConcreteOrRandom();
        await localDataSource?.cacheNumberTriva(numberTrivia as NumberTriviaModel);
        return Right(numberTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource?.getLastNumberTrivia();
        return Right(localTrivia as NumberTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
