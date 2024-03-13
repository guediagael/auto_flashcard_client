import 'dart:async';
import 'dart:io';

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
    List<ExtractedPdf> documents =
        await dataRepository.apiImpl.loadPdf(File(event.documentPath));

    if (documents.isNotEmpty) {
      for (var doc in documents) {
        final docName= event.documentPath.split('/').last.split('.')[0];
        doc.name = docName;
        await dataRepository.docDatabase.insertDocument(doc);
      }
      emit(const HomeStateNewDocumentUploaded());
    } else {
      emit(HomeStateUploadDocumentError(errorMessage: "No documents uploaded"));
    }
  }

  FutureOr<void> _triggerDocumentUpLoading(
      HomeEventTriggerUploadLoading event, Emitter<BaseState> emit) {
    emit(HomeStateUploadDocumentLoading(event.documentPath));
  }
}
