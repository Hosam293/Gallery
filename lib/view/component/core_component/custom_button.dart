import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomButton extends StatelessWidget {

Color buttonColor;
 VoidCallback? onPressed;

CustomButton(
      {required this.buttonColor,this.onPressed,
      this.borderRadius=10,
      required this.widget});

  double borderRadius;
Widget widget;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      style: ElevatedButton.styleFrom(
        primary: buttonColor,

        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
      ),
      onPressed: onPressed,

      child: widget,
    );
  }
}
