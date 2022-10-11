import 'dart:convert';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_clean_arch/core/error/exceptions.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/models/number_trivia_model.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  NumberTriviaRemoteDataSource? remoteDataSourceImplementation;
  MockClient? mockClient;

  setUp(() {
    mockClient = MockClient();
    remoteDataSourceImplementation = NumberTriviaRemoteDataSourceImplementation(client: mockClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockClient?.get(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockClient?.get(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test('Should peform a GET request on a URL with number being the endpoint and with application/json header', () async {
      final Uri mockUri = Uri(scheme: 'http', host: 'numbersapi.com', path: '$tNumber');
      setUpMockHttpClientSuccess200();
      await remoteDataSourceImplementation?.getConcreteNumberTribia(tNumber);
      verify(await mockClient?.get(mockUri, headers: {'ContentType': 'application/json'}));
    });

    test('Should return NumberTrivia when the response code is 200 (success)', () async {
      setUpMockHttpClientSuccess200();
      final result = await remoteDataSourceImplementation?.getConcreteNumberTribia(tNumber);
      expect(result, equals(tNumberTriviaModel));
    });

    test('Should thow a ServerException when the response code is 404 or other', () {
      setUpMockHttpClientFailure404();
      final call = remoteDataSourceImplementation?.getConcreteNumberTribia;
      expect(() => call!(tNumber), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
