import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_test/colors/colors_app.dart';
import 'package:internship_test/colors/colors_background.dart';
import 'package:internship_test/screens/integrating_sceens.dart';
import 'package:internship_test/screens/main_page_screens.dart';
import 'package:internship_test/widgets/custom_button.dart';
// Import the CustomButton class

class ChoseScreens extends StatelessWidget {
  const ChoseScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: BackgroundColor.gradient,
        ),
        child: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  text: 'Task 1',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                             const MainPageScreens()), // Navigate to MainPageScreens
                    );
                  },
                  textStyle: TextStyle(
                      color: ColorsApp.black1,
                      fontSize: MediaQuery.of(context).size.width * 0.05),
                  width: 200.w,
                  height: 50.h,
                ),
                SizedBox(height: 20.h), // Add some spacing between buttons
                CustomButton(
                  text: 'Task 2',
                  onPressed: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                             const IntegratingSceens()), // Navigate to MainPageScreens
                    );
                  },
                  // color: Colors.green,
                  textStyle: TextStyle(
                      color: ColorsApp.black1,
                      fontSize: MediaQuery.of(context).size.width * 0.05),
                  width: 200.w,
                  height: 50.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
