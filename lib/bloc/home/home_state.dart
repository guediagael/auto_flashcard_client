import 'package:client/bloc/base/base_state.dart';

class HomeStateInitial extends BaseState {
  const HomeStateInitial() : super(const []);
}

class HomeStateNewDocumentUploaded extends BaseState {
  const HomeStateNewDocumentUploaded() : super(const []);
}

class HomeStateUploadDocumentError extends BaseState {
  final String errorMessage;

  HomeStateUploadDocumentError({required this.errorMessage})
      : super([errorMessage]);
}
