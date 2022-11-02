import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomAuthFormField extends StatelessWidget {
  TextEditingController? controller;
  String? title;
  String? hintText;
  double? fontSize;
  Widget? suffixIcon;
  Widget? prefixIcon;
  FormFieldValidator<String>? validator;
  TextInputType? type;
  GestureTapCallback? onTap;
  bool obscureText;
  bool readonly;
  AutovalidateMode? autovalidateMode;

  CustomAuthFormField(
      {Key? key,
        this.controller,
        this.readonly = false,
        this.title,
        this.hintText,
        this.fontSize = 14,
        this.suffixIcon,
        this.prefixIcon,
        this.validator,
        this.type,
        this.onTap,
        this.obscureText = false,this.autovalidateMode=AutovalidateMode.onUserInteraction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      readOnly: readonly,
      onTap: onTap,
      validator: validator,
      cursorColor: Color(0xff9D9491),
      autovalidateMode: autovalidateMode,
      maxLines: 1,
      controller: controller,
      keyboardType: type,
      obscureText: obscureText,
      style: TextStyle(
        color: Color(0xff9D9491),
        fontWeight: FontWeight.w600,

      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsetsDirectional.fromSTEB(22.w, 13.h, 0.w, 13.h),

        filled: true,
        errorMaxLines: 2,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        labelText: title,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Color(0xff9D9491),
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: TextStyle(
          color: Color(0xff9D9491),
          fontSize: fontSize,
        ),
        fillColor: Colors.white,
        border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(33.r),
            borderSide: BorderSide.none),
        errorBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(33.r),
            borderSide: BorderSide.merge(
                BorderSide(
                    color: Colors.red, width: 1, style: BorderStyle.solid),
                BorderSide(
                    color: Colors.red, width: 1, style: BorderStyle.solid))),
        errorStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

// focusedErrorBorder: OutlineInputBorder(
// borderSide: BorderSide(
// color: prefCubit.isDark ? mainButtonColor : darkThemeIconColor,
// width: 1),
// borderRadius: BorderRadius.circular(10),
// ),

// enabledBorder: OutlineInputBorder(
// borderSide: BorderSide(
// color: prefCubit.isDark ? libalColor : darkThemeIconColor,
// width: 0),
// borderRadius: BorderRadius.circular(10),
//
// ),

// focusedBorder: OutlineInputBorder(
// borderSide: BorderSide(
// color: prefCubit.isDark ? libalColor : darkThemeIconColor,
// width: 0),
// borderRadius: BorderRadius.circular(10),
// ),