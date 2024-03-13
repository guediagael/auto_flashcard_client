import 'package:flutter/material.dart';

import '../../main.dart';

class ServerException implements Exception {}

class CacheException implements Exception {}

class NetworkException implements Exception {}

class NoInternetException implements Exception {
  late String _message;

  NoInternetException([String message = "No Internet exception occurred"]) {
    if (globalMessengerKey.currentState != null) {
      ScaffoldMessenger.of(globalMessengerKey.currentState!.context)
          .showSnackBar(SnackBar(content: Text(message)));
    }

    _message = message;
  }

  @override
  String toString() {
    return "NoInternetException(message: $_message)";
  }
}
