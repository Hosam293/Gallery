import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomText extends StatelessWidget {
  String text;
  double height;
  int? maxLines;
  TextOverflow? textOverflow;

  CustomText(
      {Key? key, required this.text,this.decoration=TextDecoration.none,this.textAlign=TextAlign.justify, this.color=Colors.white, required this.fontSize,  this.fontWeight=FontWeight.normal,  this.fontFamily='Roboto-Regular',this.height=1,this.maxLines=2,this.textOverflow}) : super(key: key);

  Color color;
  double fontSize;
  FontWeight fontWeight;
  String fontFamily;
  TextDecoration decoration;
  TextAlign textAlign;


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
            color:color ,
            fontSize: fontSize,
            fontWeight: fontWeight,

            decoration: decoration,
            height: height

        )
      ),
      textAlign:textAlign ,
      maxLines: maxLines,
      overflow:textOverflow ,
      softWrap: true,
    );
  }
}