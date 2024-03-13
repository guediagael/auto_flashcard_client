import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/login_screen.dart';
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
      : super(listener: (context, state) {
          debugPrint("base_bloc_listener::listener().state $state");
          if (state is SendErrorState) {
            messenger.showErrorInfoDialog(
                title: "Error",
                errorMessage: state.errorMessage,
                onPositiveTap: state.onOkPressed != null
                    ? () => state.onOkPressed!()
                    : () => Navigator.of(context).pop());
          } else if (state is DialogSessionExpired) {
            messenger.showErrorInfoDialog(
                title: state.title ?? "Error",
                errorMessage: state.errorMessage ??
                    "Session Expired.\n You will be redirected to login screen",
                onPositiveTap: () => state.onPositiveTap());
          } else if (state is DialogLongErrorState) {
            messenger.showErrorInfoDialog(
                title: state.title ?? "Error",
                errorMessage: state.errorMessage ?? "Something bad happened",
                onPositiveTap: () => state.onPositiveTap());
          } else if (state is SnackBarShortErrorState) {
            messenger.showErrorSnackBar(state.errorMessage);
          } else if (state is ScreenErrorState) {
            messenger.showActionableErrorDialog(
                title: "Error ! 😥",
                errorMessage: state.errorMessage,
                onPositiveTap: () => state.onRetryPressed(),
                onNegativeTap: () => Navigator.of(context).pop());
          } else if (state is SendToLoginState) {
            debugPrint("base_bloc_listener Sending to Login");
            Navigator.pushNamedAndRemoveUntil(
                context, LoginScreen.routeName, (route) => false);
          } else if (state is RequestPermissionState) {
            //   TODO: request permission
          } else if (state is SnackBarShortErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ));
          } else {
            listener(context, state);
          }
        });

  @override
  BlocListener copyWith(Widget child) {
    return BlocListener(key: key, bloc: bloc, listener: listener, child: child);
  }
}
