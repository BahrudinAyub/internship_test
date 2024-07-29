import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_test/colors/colors_app.dart';

class ArrowBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ArrowBackButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.w, // Responsive width
      height: 50.h, // Responsive height
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: ColorsApp.purple, 
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorsApp.black1,
              width: 3.w,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.arrow_back,
              color: Colors.black, // Icon color
              size: 40, // Responsive icon size
            ),
          ),
        ),
      ),
    );
  }
}
