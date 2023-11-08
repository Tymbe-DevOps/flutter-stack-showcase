import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectionChecker;

  NetworkInfoImpl(Connectivity connectionChecker) : _connectionChecker = connectionChecker;

  @override
  Future<bool> get isConnected =>
      _connectionChecker.checkConnectivity().then((value) => value != ConnectivityResult.none);
}
