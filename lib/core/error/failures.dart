import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List<dynamic> properties = const [];

  @override
  List<Object?> get props => [properties];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NullFailure extends Failure {}
