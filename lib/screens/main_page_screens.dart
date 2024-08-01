import 'package:flutter/material.dart';
import 'package:internship_test/colors/colors_app.dart';
import 'package:internship_test/colors/colors_background.dart';
import 'package:internship_test/screens/chose_screens.dart';
import 'package:internship_test/widgets/appbar_icons.dart';
import 'package:internship_test/widgets/back_button.dart';
import 'package:internship_test/widgets/username_input_widget.dart';

class MainPageScreens extends StatefulWidget {
  const MainPageScreens({super.key});

  @override
  _MainPageScreensState createState() => _MainPageScreensState();
}

class _MainPageScreensState extends State<MainPageScreens> {
  bool _isUploadCompleted = false;

  void _updateUploadStatus(bool status) {
    setState(() {
      _isUploadCompleted = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Transform.translate(
          offset: const Offset(20.0, 0.0), 
          child: ArrowBackButton(onPressed: () {
            Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                             const ChoseScreens()), // Navigate to MainPageScreens
                    );
          }),
        ),
        backgroundColor: ColorsApp.background1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0), 
            child: AppbarIcon(isCompleted: _isUploadCompleted), 
          ),
        ],
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: BackgroundColor.gradient, 
        ),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 40.0, 
                child: UsernameInputWidget(
                  username: 'John Doe 86',
                  onUploadStatusChanged: _updateUploadStatus, 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
