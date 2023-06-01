// Mocks generated by Mockito 5.3.2 from annotations
// in tdd_clean_arch/test/features/number_trivia/presentation/bloc/number_trivia_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tdd_clean_arch/core/error/failures.dart' as _i6;
import 'package:tdd_clean_arch/core/usecases/no_params.dart' as _i8;
import 'package:tdd_clean_arch/core/util/input_converter.dart' as _i10;
import 'package:tdd_clean_arch/features/number_trivia/domain/entities/number_trivia.dart'
    as _i7;
import 'package:tdd_clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart'
    as _i2;
import 'package:tdd_clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart'
    as _i9;
import 'package:tdd_clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart'
    as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeNumberTriviaRepository_0 extends _i1.SmartFake
    implements _i2.NumberTriviaRepository {
  _FakeNumberTriviaRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetRandomNumberTriviaUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetRandomNumberTriviaUseCase extends _i1.Mock
    implements _i4.GetRandomNumberTriviaUseCase {
  @override
  _i2.NumberTriviaRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeNumberTriviaRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeNumberTriviaRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.NumberTriviaRepository);
  @override
  set repository(_i2.NumberTriviaRepository? _repository) => super.noSuchMethod(
        Invocation.setter(
          #repository,
          _repository,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.NumberTrivia>> call(
          _i8.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, _i7.NumberTrivia>>.value(
                _FakeEither_1<_i6.Failure, _i7.NumberTrivia>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, _i7.NumberTrivia>>.value(
                _FakeEither_1<_i6.Failure, _i7.NumberTrivia>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.NumberTrivia>>);
}

/// A class which mocks [GetConcreteNumberTriviaUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetConcreteNumberTriviaUseCase extends _i1.Mock
    implements _i9.GetConcreteNumberTriviaUseCase {
  @override
  _i2.NumberTriviaRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeNumberTriviaRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeNumberTriviaRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.NumberTriviaRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.NumberTrivia>> call(
          _i9.Params? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, _i7.NumberTrivia>>.value(
                _FakeEither_1<_i6.Failure, _i7.NumberTrivia>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, _i7.NumberTrivia>>.value(
                _FakeEither_1<_i6.Failure, _i7.NumberTrivia>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.NumberTrivia>>);
}

/// A class which mocks [InputConverter].
///
/// See the documentation for Mockito's code generation for more information.
class MockInputConverter extends _i1.Mock implements _i10.InputConverter {
  @override
  _i3.Either<_i6.Failure, int> stringToUnsignedInteger(String? str) =>
      (super.noSuchMethod(
        Invocation.method(
          #stringToUnsignedInteger,
          [str],
        ),
        returnValue: _FakeEither_1<_i6.Failure, int>(
          this,
          Invocation.method(
            #stringToUnsignedInteger,
            [str],
          ),
        ),
        returnValueForMissingStub: _FakeEither_1<_i6.Failure, int>(
          this,
          Invocation.method(
            #stringToUnsignedInteger,
            [str],
          ),
        ),
      ) as _i3.Either<_i6.Failure, int>);
}
