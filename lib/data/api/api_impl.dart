import 'dart:io';

import 'package:client/data/api/api_client.dart';
import 'package:client/data/shared_prefs/data_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../constants/secrets.dart';
import '../model/extracted_pdf.dart';
import 'document_parser/pdf_loader.dart';

class ApiImpl with PdfLoaderApi {
  late final ApiClient _apiClient;
  late final DataPreferences _dataPreferences;
  Function(String?)? _redirectToLogin;

  ApiImpl(
      {Function(String?)? redirectToLogin,
      required DataPreferences dataPreferences,
      required String defaultLanguage}) {
    _apiClient = ApiClient(
        vertexBasePath: vertexBasePath,
        pdfLoaderBasePath: documentLoaderBasePath,
        language: defaultLanguage);
    _dataPreferences = dataPreferences;
    _redirectToLogin = redirectToLogin;
  }

  @override
  Future<List<ExtractedPdf>> loadPdf(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "pdf": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    return _apiClient.pdfLoaderClient
        .post('/parse_pdf', data: formData)
        .then((value) {
      try {
        final result = <ExtractedPdf>[];
        if (value.data != null) {
          for (var element in (value.data as List)) {
            var extractedPdf = ExtractedPdf.fromJson(element);
            if (extractedPdf != null) {
              result.add(extractedPdf);
            }
          }
          return result;
        } else {
          debugPrint("ApiImpl::loadPdf : empty result");
        }
      } on Exception catch (e, stackTrace) {
        debugPrintStack(
            stackTrace: stackTrace,
            label: "ApiImpl::loadPdf : value not list $e");
      }

      return <ExtractedPdf>[];
    });
  }

  @override
  Future<Map<String, List<ExtractedPdf>>> loadPdfs(List<File> files) {
    return Future.value({});
  }
}
