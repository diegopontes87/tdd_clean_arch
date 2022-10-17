import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tNumberTriviaModel = NumberTriviaModel(number: 1, text: '1 test');
  test('Should be a subclass of NumberTrivia entity', () async {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('fromJson', () {
    test('Should return a valid model when JSON number is an integer', () async {
      Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
      var result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, equals(tNumberTriviaModel));
    });

    test('Should return a valid model when JSON number is regarded as an double', () async {
      Map<String, dynamic> jsonMap = json.decode(fixture('trivia_double.json'));
      var result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, equals(tNumberTriviaModel));
    });
  });

  group('toJson', () {
    test('Should return a JSON map containing the proper data ', () {
      final result = tNumberTriviaModel.toJson();
      final map = {"text": "1 test", "number": 1};
      expect(result, map);
    });
  });
}
