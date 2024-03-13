import 'dart:io';

import '../../model/extracted_pdf.dart';

abstract mixin class PdfLoaderApi {
  static PdfLoaderApi? _() {
    return null;
  }

  Future<List<ExtractedPdf>> loadPdf(File file);

  //Premium only
  Future<Map<String, List<ExtractedPdf>>> loadPdfs(List<File> files);
}
