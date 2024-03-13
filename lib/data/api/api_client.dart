import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart';

class ApiClient {
  late final Dio vertexClient;
  late final Dio pdfLoaderClient;

  ApiClient(
      {required String vertexBasePath,
      required String pdfLoaderBasePath,
      required String language}) {
    pdfLoaderClient = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        baseUrl: pdfLoaderBasePath,
        contentType: Headers.jsonContentType,
        headers: {'language': language}));
    pdfLoaderClient.interceptors.add(LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        logPrint: (string) {
          debugPrint("*** PdfLoader Client*** $string");
        }));
  }

  Future activateCacheInterceptor() async {
    final tempDir = await getTemporaryDirectory();
    CacheStore cacheStore = HiveCacheStore(tempDir.path);

    // Global options
    final options = CacheOptions(
      // A default store is required for interceptor.
      store: cacheStore,

      // All subsequent fields are optional.

      // Default.
      policy: CachePolicy.request,
      // Returns a cached response on error but for statuses 401 & 403.
      // Also allows to return a cached response on network errors (e.g. offline usage).
      // Defaults to [null].
      hitCacheOnErrorExcept: [401, 403],
      // Overrides any HTTP directive to delete entry past this duration.
      // Useful only when origin server has no cache config or custom behaviour is desired.
      // Defaults to [null].
      maxStale: const Duration(days: 7),
      // Default. Allows 3 cache sets and ease cleanup.
      priority: CachePriority.normal,
      // Default. Body and headers encryption with your own algorithm.
      cipher: null,
      // Default. Key builder to retrieve requests.
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      // Default. Allows to cache POST requests.
      // Overriding [keyBuilder] is strongly recommended when [true].
      allowPostMethod: false,
    );

    pdfLoaderClient.interceptors.add(DioCacheInterceptor(options: options));
  }
}
