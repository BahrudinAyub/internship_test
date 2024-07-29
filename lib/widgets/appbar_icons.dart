import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_test/colors/colors_app.dart';
import 'package:internship_test/fonts/font_satoshi.dart';

class AppbarIcon extends StatelessWidget {
  final bool isCompleted; // Indicates upload status

  const AppbarIcon({Key? key, required this.isCompleted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
      decoration: BoxDecoration(
        color: isCompleted ? ColorsApp.green : ColorsApp.yellow, // Background color
        border: Border.all(color: Colors.black, width: 2), 
        borderRadius: BorderRadius.circular(35), 
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isCompleted ? 'Completed Profile' : 'Incomplete Profile', // Change text based on status
            style: SatoshiTextStyle.normalStyle.copyWith(
              fontSize: MediaQuery.of(context).size.width * 0.04,
            ),
          ),
          SizedBox(width: 8.h), // Jarak antara teks dan ikon
          Container(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              Icons.error, 
              color: isCompleted ? Colors.white : ColorsApp.dangericon, 
              size: 24.sp, 
            ),
          ),
        ],
      ),
    );
  }
}
