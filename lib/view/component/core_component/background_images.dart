import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackGroundImages extends StatelessWidget {
  const BackGroundImages({
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
            left: -80.sp,
            child: Image.asset('assets/images/Ellipse 1627.png')),
        Positioned(
            bottom: -80.sp,
            left: 0,
            right: 0,
            child: Image.asset('assets/images/orange.png')),
      ],
    );
  }
}
