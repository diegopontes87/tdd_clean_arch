import 'dart:convert';

import 'package:tdd_clean_arch/core/error/exceptions.dart';

import '../models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTribia(int number);
  Future<NumberTriviaModel> getRambomNumberTribia();
}

class NumberTriviaRemoteDataSourceImplementation implements NumberTriviaRemoteDataSource {
  final http.Client? client;

  NumberTriviaRemoteDataSourceImplementation({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTribia(int number) async {
    var response = await client?.get(
        Uri(
          scheme: 'http',
          host: 'numbersapi.com',
          path: '$number',
        ),
        headers: {'ContentType': 'application/json'});
    if (response?.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response?.body ?? ''));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<NumberTriviaModel> getRambomNumberTribia() async {
    var response = await client?.get(
        Uri(
          scheme: 'http',
          host: 'numbersapi.com',
          path: 'random',
        ),
        headers: {'ContentType': 'application/json'});
    if (response?.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response?.body ?? ''));
    } else {
      throw ServerException();
    }
  }
}
