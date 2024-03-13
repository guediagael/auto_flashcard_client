import 'package:flutter/widgets.dart';

class ExtractedPdf {
  static const pageContentColumnName = "page_content";
  static const pageColumnName = "page";
  static const nameColumnName = "name";
  static const idColumnName = "id";

  final String pageContent;
  final int page;
  String? name;
  final int? id;

  ExtractedPdf(
      {required this.pageContent, required this.page, this.name, this.id});


  static ExtractedPdf? fromJson(Map<String, dynamic> json) {
    try {
      return ExtractedPdf(
          pageContent: json['page_content'], page: json['page']);
    } on Exception catch (e, stacktrace) {
      debugPrintStack(
          stackTrace: stacktrace, label: "ExtractedPdf::fromJson $e");
    }
    return null;
  }

  Map<String, dynamic> toMap() {
    return {
      pageContentColumnName: pageContent,
      nameColumnName: name,
      pageColumnName: page
    };
  }

  @override
  String toString() {
    return 'ExtractedPdf(pageContent: $pageContent, page: $page)';
  }
}
