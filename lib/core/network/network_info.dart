import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> isConnected();

  Future<ConnectivityResult> get connectivityResult;

  Stream<ConnectivityResult> get onConnectivityChanged;
}

class NetworkInfoImpl implements NetworkInfo {
  Connectivity connectivity;

  static final NetworkInfoImpl _networkInfo =
      NetworkInfoImpl._internal(Connectivity());

  factory NetworkInfoImpl() => _networkInfo;

  NetworkInfoImpl._internal(this.connectivity);

  @override
  Future<ConnectivityResult> get connectivityResult =>
      connectivity.checkConnectivity();

  @override
  Future<bool> isConnected() async {
    final result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  @override
  Stream<ConnectivityResult> get onConnectivityChanged =>
      connectivity.onConnectivityChanged;
}
