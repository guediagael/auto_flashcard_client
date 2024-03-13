import 'package:client/bloc/base/base_state.dart';

class HomeStateInitial extends BaseState {
  const HomeStateInitial() : super(const []);
}

class HomeStateNewDocumentUploaded extends BaseState {
  const HomeStateNewDocumentUploaded() : super(const []);
}

class HomeStateUploadDocumentLoading extends BaseState {
  final String documentPath;

  HomeStateUploadDocumentLoading(this.documentPath) : super([documentPath]);
}

class HomeStateUploadDocumentError extends BaseState {
  final String errorMessage;

  HomeStateUploadDocumentError({required this.errorMessage})
      : super([errorMessage]);
}
