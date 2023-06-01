import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_arch/core/util/input_converter.dart';

void main() {
  InputConverter? inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });
  group('stringToUnsignedInteger', () {
    test('Should return an integer when the string represents an unsigned integer', () async {
      const str = '123';
      final result = inputConverter?.stringToUnsignedInteger(str);
      expect(result, const Right(123));
    });

    test('Should return a failure when the string is not an integer', () async {
      const str = '1.0';
      final result = inputConverter?.stringToUnsignedInteger(str);
      expect(result, Left(InvalidInputFailure()));
    });

    test('Should return a failure when the string is a negative integer', () async {
      const str = '-123';
      final result = inputConverter?.stringToUnsignedInteger(str);
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
