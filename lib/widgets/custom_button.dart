import 'package:flutter/material.dart';
import 'package:internship_test/colors/colors_app.dart';
import 'package:internship_test/fonts/font_satoshi.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final TextStyle textStyle;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final double borderWidth;
  final Color borderColor;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = ColorsApp.purple,
    this.textStyle = SatoshiTextStyle.normalStyle,
    this.width = double.infinity,
    this.height = 50.0,
    this.padding = const EdgeInsets.all(8.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(20.0)),
    this.borderWidth = 2.0,
    this.borderColor = ColorsApp.black1 // Default border color is black
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: BorderSide(
              color: borderColor,
              width: borderWidth,
              
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: textStyle),
      ),
    );
  }
}
