import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginBackGround extends StatelessWidget {
  const LoginBackGround({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            bottom: 0,
            top: 0,
            right: 0,
            child: Image.asset('assets/images/pink.png')),
        Positioned(
            bottom: 0,
            left: -80,
            child: Image.asset('assets/images/Ellipse 1627.png')),
        Positioned(left: 0,
            right: 0,
            bottom: -80,

            child: Image.asset('assets/images/Ellipse 1629.png',fit: BoxFit.cover,height: 300,width: 400.w)),
      ],
    );
  }
}
