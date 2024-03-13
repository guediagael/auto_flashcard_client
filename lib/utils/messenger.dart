import 'package:flutter/widgets.dart';

class Messenger {
  final BuildContext context;
  Messenger(this.context);

  void showErrorInfoDialog(
      {required String title,
      required String errorMessage,
      required Function onPositiveTap}) {}

  void  showErrorSnackBar(String message){

  }

  void showActionableErrorDialog({required String title,
    required String errorMessage,
    required Function onPositiveTap, required Function onNegativeTap}){}
}
