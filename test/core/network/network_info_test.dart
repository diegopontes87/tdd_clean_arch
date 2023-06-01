import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_arch/core/network/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<DataConnectionChecker>(),
])
void main() {
  NetworkInfo? networkInfo;
  MockDataConnectionChecker? mockDataConnectionChecker;
  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImplementation(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test('Should foward the call to DataConnectionCheker.hasConnection', () {
      final tHasConnectionFuture = Future.value(true);
      when(mockDataConnectionChecker?.hasConnection).thenAnswer((_) => tHasConnectionFuture);
      final result = networkInfo?.isConnected;
      verify(mockDataConnectionChecker?.hasConnection);
      expect(result, tHasConnectionFuture);
    });
  });
}
