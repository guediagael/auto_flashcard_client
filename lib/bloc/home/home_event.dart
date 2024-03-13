import '../base/base_event.dart';

class HomeEventUploadDocument extends BaseEvent {
  final String documentPath;

  HomeEventUploadDocument({required this.documentPath}) : super([documentPath]);
}

class HomeEventTriggerUploadLoading extends BaseEvent {
  final String documentPath;

  HomeEventTriggerUploadLoading({required this.documentPath})
      : super([documentPath]);
}
