import 'package:flutter/material.dart';

class ServerException implements Exception {}

class CacheException implements Exception {}

class NetworkException implements Exception {}

class NoInternetException implements Exception {
  late String _message;

  NoInternetException(BuildContext context,
      [String message = "No Internet exception occurred"]) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));

    _message = message;
  }

  @override
  String toString() {
    return "NoInternetException(message: $_message)";
  }
}

class ClientException implements Exception {
  late String _message;

  ClientException({required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));

    _message = message;
  }

  @override
  String toString() {
    return "ClientException(message: $_message)";
  }
}
