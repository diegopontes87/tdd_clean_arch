import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean_arch/core/error/exceptions.dart';
import 'package:tdd_clean_arch/core/error/failures.dart';
import 'package:tdd_clean_arch/core/platform/network_info.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<NumberTriviaRemoteDataSource>(),
  MockSpec<NumberTriviaLocalDataSource>(),
  MockSpec<NetworkInfo>(),
])
void main() {
  NumberTriviaRepositoryImplementation? repository;
  MockNumberTriviaRemoteDataSource? mockRemoteDataSource;
  MockNumberTriviaLocalDataSource? mocklocalDataSource;
  MockNetworkInfo? mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockNumberTriviaRemoteDataSource();
    mocklocalDataSource = MockNumberTriviaLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImplementation(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mocklocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('Device is online', () {
      setUp(() {
        when(mockNetworkInfo?.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('Device is offline', () {
      setUp(() {
        when(mockNetworkInfo?.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getConcrete number trivia', () {
    const int tNumber = 1;
    const tNumberTriviaModel = NumberTriviaModel(number: tNumber, text: 'test trivia');
    const tNumberTrivia = tNumberTriviaModel;
    test('Should check if the device is online', () async {
      when(mockNetworkInfo?.isConnected).thenAnswer((_) async => true);
      await repository?.getConcreteNumberTribia(tNumber);
      verify(mockNetworkInfo?.isConnected);
    });

    runTestsOnline(() {
      test('Should return remote data when the call to remote data source is successful', () async {
        when(mockRemoteDataSource?.getConcreteNumberTribia(any)).thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository?.getConcreteNumberTribia(1);
        verify(await mockRemoteDataSource?.getConcreteNumberTribia(tNumber));
        expect(result, equals(const Right(tNumberTrivia)));
      });

      test('Should cache the data locally when the call to remote data source is successful', () async {
        when(mockRemoteDataSource?.getConcreteNumberTribia(any)).thenAnswer((_) async => tNumberTriviaModel);
        await repository?.getConcreteNumberTribia(1);
        verify(await mockRemoteDataSource?.getConcreteNumberTribia(tNumber));
        verify(await mocklocalDataSource?.cacheNumberTriva(tNumberTriviaModel));
      });

      test('Should return server failure when the call to remote data source is unsuccessful', () async {
        when(await mockRemoteDataSource?.getConcreteNumberTribia(any)).thenThrow((ServerException()));
        final result = await repository?.getConcreteNumberTribia(1);
        verify(await mockRemoteDataSource?.getConcreteNumberTribia(tNumber));
        verifyZeroInteractions(mocklocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test('Should return last locally cached data when the cached data is present', () async {
        when(mocklocalDataSource?.getLastNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository?.getConcreteNumberTribia(tNumber);
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mocklocalDataSource?.getLastNumberTrivia());
        expect(result, equals(const Right(tNumberTrivia)));
      });

      test('Should return CacheFailure when there is no cached data present', () async {
        when(mocklocalDataSource?.getLastNumberTrivia()).thenThrow(CacheException());
        final result = await repository?.getConcreteNumberTribia(tNumber);
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mocklocalDataSource?.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

  group('getRandom number trivia', () {
    const tNumberTriviaModel = NumberTriviaModel(number: 123, text: 'test trivia');
    const tNumberTrivia = tNumberTriviaModel;
    test('Should check if the device is online', () async {
      when(mockNetworkInfo?.isConnected).thenAnswer((_) async => true);
      await repository?.getRambomNumberTribia();
      verify(mockNetworkInfo?.isConnected);
    });

    runTestsOnline(() {
      test('Should return remote data when the call to remote data source is successful', () async {
        when(mockRemoteDataSource?.getRambomNumberTribia()).thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository?.getRambomNumberTribia();
        verify(await mockRemoteDataSource?.getRambomNumberTribia());
        expect(result, equals(const Right(tNumberTrivia)));
      });

      test('Should cache the data locally when the call to remote data source is successful', () async {
        when(mockRemoteDataSource?.getRambomNumberTribia()).thenAnswer((_) async => tNumberTriviaModel);
        await repository?.getRambomNumberTribia();
        verify(await mockRemoteDataSource?.getRambomNumberTribia());
        verify(await mocklocalDataSource?.cacheNumberTriva(tNumberTriviaModel));
      });

      test('Should return server failure when the call to remote data source is unsuccessful', () async {
        when(await mockRemoteDataSource?.getRambomNumberTribia()).thenThrow((ServerException()));
        final result = await repository?.getRambomNumberTribia();
        verify(await mockRemoteDataSource?.getRambomNumberTribia());
        verifyZeroInteractions(mocklocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test('Should return last locally cached data when the cached data is present', () async {
        when(mocklocalDataSource?.getLastNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository?.getRambomNumberTribia();
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mocklocalDataSource?.getLastNumberTrivia());
        expect(result, equals(const Right(tNumberTrivia)));
      });

      test('Should return CacheFailure when there is no cached data present', () async {
        when(mocklocalDataSource?.getLastNumberTrivia()).thenThrow(CacheException());
        final result = await repository?.getRambomNumberTribia();
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mocklocalDataSource?.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
