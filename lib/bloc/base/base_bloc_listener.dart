import 'package:client/screens/login_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/loading_overlay.dart';
import '../../utils/messenger.dart';
import '../../utils/copyable_widget.dart';
import 'base_bloc.dart';
import 'base_event.dart';
import 'base_state.dart';

class BaseBlocListener<E extends BaseEvent, S extends BaseState>
    extends BlocListener with CopyableWidget {
  BaseBlocListener(
      {super.key,
      required BaseBloc super.bloc,
      required Messenger messenger,
      required BlocWidgetListener<S> listener,
      super.child})
      : super(listener: (context, listenerState) {
          debugPrint(
              "base_bloc_listener::listener().previousStateType ${bloc.previousStateType}, type ${bloc.previousStateType.runtimeType}");
          if (bloc.previousStateType == DisplayFullScreenLoadingDialogState) {
            Navigator.of(context).pop();
            debugPrint("base_bloc_listener::listener() popped previousScreen");
          }
          debugPrint("base_bloc_listener::listener().state $listenerState");
          if (listenerState is SendErrorState) {
            messenger.showErrorInfoDialog(
                title: "Error",
                errorMessage: listenerState.errorMessage,
                onPositiveTap: listenerState.onOkPressed != null
                    ? () => listenerState.onOkPressed!()
                    : () => Navigator.of(context).pop());
          } else if (listenerState is DialogSessionExpired) {
            messenger.showErrorInfoDialog(
                title: listenerState.title ?? "Error",
                errorMessage: listenerState.errorMessage ??
                    "Session Expired.\n You will be redirected to login screen",
                onPositiveTap: () => listenerState.onPositiveTap());
          } else if (listenerState is DialogLongErrorState) {
            messenger.showErrorInfoDialog(
                title: listenerState.title ?? "Error",
                errorMessage:
                    listenerState.errorMessage ?? "Something bad happened",
                onPositiveTap: () => listenerState.onPositiveTap());
          } else if (listenerState is SnackBarShortErrorState) {
            messenger.showErrorSnackBar(listenerState.errorMessage);
          } else if (listenerState is ScreenErrorState) {
            messenger.showActionableErrorDialog(
                title: "Error ! 😥",
                errorMessage: listenerState.errorMessage,
                onPositiveTap: () => listenerState.onRetryPressed(),
                onNegativeTap: () => Navigator.of(context).pop());
          } else if (listenerState is SendToLoginState) {
            debugPrint("base_bloc_listener Sending to Login");
            Navigator.pushNamedAndRemoveUntil(
                context, LoginFormScreen.routeName, (route) => false);
          } else if (listenerState is RequestPermissionState) {
            //   TODO: request permission
          } else if (listenerState is SnackBarShortErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(listenerState.errorMessage),
              backgroundColor: Colors.red,
            ));
          } else if (listenerState is DisplayFullScreenLoadingDialogState) {
            Navigator.of(context).push(LoadingOverlay());
          } else if (listenerState is FirebaseAuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(listenerState.errorMessage)));
          }
          listener(context, listenerState);
        });

  @override
  BlocListener copyWith(Widget child) {
    return BlocListener(key: key, bloc: bloc, listener: listener, child: child);
  }
}
