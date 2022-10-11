import 'package:tdd_clean_arch/core/error/exceptions.dart';
import 'package:tdd_clean_arch/core/platform/network_info.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_arch/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart';

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
    var isConnected = await networkInfo?.isConnected;
    if (isConnected!) {
      try {
        var remoteTrivia = await remoteDataSource?.getConcreteNumberTribia(number);
        localDataSource?.cacheNumberTriva(remoteTrivia!);
        return Right(remoteTrivia as NumberTrivia);
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

  @override
  Future<Either<Failure, NumberTrivia>> getRambomNumberTribia() async {
    var isConnected = await networkInfo?.isConnected;
    if (isConnected!) {
      try {
        var remoteTrivia = await remoteDataSource?.getRambomNumberTribia();
        localDataSource?.cacheNumberTriva(remoteTrivia!);
        return Right(remoteTrivia as NumberTrivia);
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
