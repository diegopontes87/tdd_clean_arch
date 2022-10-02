import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_arch/core/platform/network_info.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<NumberTriviaRemoteDataSource>(),
  MockSpec<NumberTriviaLocalDataSource>(),
  MockSpec<NetworkInfo>(),
])
void main() {
  NumberTriviaRepositoryImplementation repository;
  MockNumberTriviaRemoteDataSource remoteDataSource;
  MockNumberTriviaLocalDataSource localDataSource;
  MockNetworkInfo networkInfo;
  setUp(() {
    remoteDataSource = MockNumberTriviaRemoteDataSource();
    localDataSource = MockNumberTriviaLocalDataSource();
    networkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImplementation(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      networkInfo: networkInfo,
    );
    networkInfo = MockNetworkInfo();
  });
  group('', () {});
}
