import 'package:dartz/dartz.dart';
import 'package:tdd_clean_arch/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
