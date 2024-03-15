import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/extracted_pdf.dart';
import '../base/base_bloc.dart';
import '../base/base_state.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc {
  HomeBloc({required super.dataRepository})
      : super(initialState: const HomeStateInitial()) {
    on<HomeEventUploadDocument>(_uploadDocument);
    on<HomeEventTriggerUploadLoading>(_triggerDocumentUpLoading);
  }

  FutureOr<void> _uploadDocument(
      HomeEventUploadDocument event, Emitter<BaseState> emit) async {
    try {
      List<ExtractedPdf> documents =
          await dataRepository.apiImpl.loadPdf(File(event.documentPath));
      if (documents.isNotEmpty) {
        for (var doc in documents) {
          final docName = event.documentPath.split('/').last.split('.')[0];
          doc.name = docName;
          await dataRepository.docDatabase.insertDocument(doc);
        }
        emit(const HomeStateNewDocumentUploaded());
      } else {
        emit(HomeStateUploadDocumentError(
            errorMessage: "No documents uploaded"));
      }
    } on DioException catch (e) {
      emit(HomeStateUploadDocumentError(errorMessage: "No documents uploaded"));
      errorHandler(e, ErrorViewType.dialog);
    }
  }

  FutureOr<void> _triggerDocumentUpLoading(
      HomeEventTriggerUploadLoading event, Emitter<BaseState> emit) {
    emit(DisplayFullScreenLoadingDialogState(event.documentPath));
  }
}
