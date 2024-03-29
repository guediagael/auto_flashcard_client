import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class BaseEvent extends Equatable {
  final List<Object?> properties;

  const BaseEvent(this.properties);

  @override
  List<Object?> get props => properties;

  @override
  String toString() => '$runtimeType';
}

abstract class CommonEvent extends BaseEvent {
  const CommonEvent(super.properties);
}

class ShowDialogEvent extends CommonEvent {
  final String title, message;
  final Function? onOkayPressed;

  ShowDialogEvent(
      {required this.title, required this.message, this.onOkayPressed})
      : super([title, message, onOkayPressed]);
}

class ShowSnackBarMessageEvent extends CommonEvent {
  final String message;

  ShowSnackBarMessageEvent(this.message) : super([message]);
}

class ShowErrorScreenEvent extends CommonEvent {
  final String errorMessage;

  ShowErrorScreenEvent({required this.errorMessage}) : super([errorMessage]);
}

class SendToLoginEvent extends CommonEvent {
  SendToLoginEvent() : super([]);
}

class PromptAuthEvent extends CommonEvent {
  final String title, message;

  PromptAuthEvent({required this.title, required this.message})
      : super([title, message]);
}

class FilesPermissionRequestEvent extends CommonEvent {
  final Function(bool) callback;

  FilesPermissionRequestEvent(this.callback) : super([callback]);
}

class HttpRequestErrorEvent extends CommonEvent {
  final DioException dioException;

  HttpRequestErrorEvent({required this.dioException}) : super([dioException]);
}

class ShowFullLoadingScreenEvent extends CommonEvent {
  final Object nextEventObject;
   ShowFullLoadingScreenEvent(this.nextEventObject) : super( []);
}
