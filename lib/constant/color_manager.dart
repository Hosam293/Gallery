import 'package:flutter/material.dart';

class ColorManager {
  static Gradient logOutGradient = const LinearGradient(colors: [
    //#C83B3B - #FB4949
    Color(0xffFB4949),
    Color(0xffC83B3B),
  ], end: Alignment.topCenter, begin: Alignment.bottomCenter);
  static Gradient uploadGradient = const LinearGradient(colors: [
    Color(0xffFF9900),
    Color(0xffFFEB38),
  ], end: Alignment.topCenter, begin: Alignment.bottomCenter);
  static BoxShadow logOutShadow = BoxShadow(
    color: Color(0xffFB4949).withOpacity(0.5),
    spreadRadius: -3,
    blurRadius: 10,
    offset: Offset(-10, 0), // changes position of shadow
  );
  static BoxShadow uploadShadow = BoxShadow(
    color: Color(0xffFFEB38).withOpacity(0.5),
    spreadRadius: -3,
    blurRadius: 10,
    offset: Offset(-10, 0), // changes position of shadow
  );
  static Color white = const Color(0xffFFFFFF);
  static Color black = Colors.black;
  static Color submitButtonColor = const Color(0xff7BB3FF);
  static Color galleryButtonColor = const Color(0xffEFD8F9);
  static Color cameraButtonColor = const Color(0xffEBF6FF);

}
