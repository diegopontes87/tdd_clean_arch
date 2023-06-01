import 'dart:convert';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_clean_arch/core/error/exceptions.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_local_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  MockSharedPreferences? sharedPreferences;
  NumberTriviaLocalDataSource? localRemoteDataSource;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    localRemoteDataSource = NumberTriviaLocalDataSourceImplementation(sharedPreferences: sharedPreferences);
  });

  group('getLastNumberTriva', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));
    test('Should return NumberTrivia from shared preferences whe there is one in the cache', () async {
      when(sharedPreferences?.getString(cachedNumberTrivia)).thenReturn(fixture('trivia_cached.json'));
      final result = await localRemoteDataSource?.getLastNumberTrivia();
      verify(sharedPreferences?.getString(cachedNumberTrivia));
      expect(result, equals(tNumberTriviaModel));
    });

    test('Should throw a CachedException when there is not a cached value', () async {
      when(sharedPreferences?.getString(cachedNumberTrivia)).thenReturn(null);

      final call = localRemoteDataSource?.getLastNumberTrivia;

      expect(() => call!(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cachedNumberTrivia', () {
    test('Should call sharedPreferences to cache the data', () async {
      const tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'text');
      localRemoteDataSource?.cacheNumberTriva(tNumberTriviaModel);
      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
      verify(sharedPreferences?.setString(cachedNumberTrivia, expectedJsonString));
    });
  });
}
