import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final Color spinnerColor;
  final Color backgroundColor;

  const LoadingIndicator({
    Key? key,
    this.size = 20,
    this.backgroundColor = Colors.transparent,
    this.spinnerColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: Center(
        child: SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(spinnerColor),
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}
