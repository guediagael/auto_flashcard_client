import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.text,
    this.color,
    this.textColor,
    this.loading = false,
    required this.onPressed,
  }) : super(key: key);
  final String text;

  final Color? color;
  final Color? textColor;
  final bool loading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color?? Colors.blue,
          disabledBackgroundColor: Colors.grey,
          disabledForegroundColor: Colors.black,
          foregroundColor: textColor ?? Colors.white,
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(32),
        ),
      )),
      // height / 2

      onPressed: onPressed,
      child: loading
          ? Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: Theme.of(context)
                      .colorScheme
                      .copyWith(secondary: Colors.white70)),
              child: const SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 3.0,
                ),
              ),
            )
          : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text),
            ],
          ),
    );
  }
}
