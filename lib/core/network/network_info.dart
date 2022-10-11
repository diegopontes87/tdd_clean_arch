import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

abstract class NetworkInfo {
  Future<bool>? get isConnected;
}

class NetworkInfoImplementation implements NetworkInfo {
  final DataConnectionChecker? connectionChecker;
  NetworkInfoImplementation(this.connectionChecker);

  @override
  Future<bool>? get isConnected => connectionChecker?.hasConnection;
}
