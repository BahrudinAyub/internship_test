import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_test/colors/colors_app.dart';
import 'package:internship_test/colors/colors_background.dart';
import 'package:internship_test/fonts/font_satoshi.dart';
import 'package:internship_test/widgets/back_button.dart';
import 'package:internship_test/widgets/custom_button.dart';

class IntegratingSceens extends StatefulWidget {
  const IntegratingSceens({super.key});

  @override
  _IntegratingSceensState createState() => _IntegratingSceensState();
}

class _IntegratingSceensState extends State<IntegratingSceens> {
  static const platform = MethodChannel('com.example.deviceinfo/info');

  String _infoText = 'Press the button to get info';

  Future<void> _getDeviceInfo() async {
    try {
      final String result = await platform.invokeMethod('getDeviceInfo');
      setState(() {
        _infoText = result;
      });
    } on PlatformException catch (e) {
      setState(() {
        _infoText = "Failed to get device info: '${e.message}'.";
      });
    }
  }

  Future<void> _getVideoInfo() async {
    try {
      final String result = await platform.invokeMethod('getVideoInfo');
      setState(() {
        _infoText = result;
      });
    } on PlatformException catch (e) {
      setState(() {
        _infoText = "Failed to get video info: '${e.message}'.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 13.0, top: 12.0), 
            child: ArrowBackButton(
              onPressed: () {
                Navigator.pop(context); 
              },
            ),
          ),
          title: Text(
            'Integrating Screens',
            style: SatoshiTextStyle.normalStyle.copyWith(
              fontSize: MediaQuery.of(context).size.width * 0.05,
            ),
          ),
          centerTitle: true,
          backgroundColor: ColorsApp.background1,
        ),
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: BackgroundColor.gradient,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  text: "Get Device Info",
                  onPressed: _getDeviceInfo,
                  textStyle: SatoshiTextStyle.normalStyle.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.05),
                  width: 200.w,
                  height: 50.h,
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  text: "Get Video Info",
                  onPressed: _getVideoInfo,
                  textStyle: SatoshiTextStyle.normalStyle.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.05),
                  width: 200.w,
                  height: 50.h,
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    _infoText,
                    style: SatoshiTextStyle.normalStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
