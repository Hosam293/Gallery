import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../core_component/custom_text.dart';

class GalleryActionButton extends StatelessWidget {
  Gradient gradient;
  List<BoxShadow> boxShadow;
  String image;
  String text;


  GalleryActionButton({super.key, required this.gradient, required this.boxShadow, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.symmetric(
          vertical: 10.h, horizontal: 15.w),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 32.h,
            width: 28.w,
            alignment: Alignment.center,
            clipBehavior:
            Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(10.r),
                gradient:gradient,
                boxShadow: boxShadow),
            child: SvgPicture.asset(
                image),
          ),
          CustomText(
            text: text,
            fontSize: 20.sp,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          )
        ],
      ),
    );
  }
}
