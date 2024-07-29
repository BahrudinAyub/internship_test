import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internship_test/colors/colors_app.dart';
import 'package:internship_test/fonts/font_satoshi.dart';
import 'package:internship_test/controllers/username_controller.dart';

class UsernameInputWidget extends StatefulWidget {
  final String username;
  final ValueChanged<bool> onUploadStatusChanged; // Callback for upload status

  UsernameInputWidget({required this.username, required this.onUploadStatusChanged});

  @override
  _UsernameInputWidgetState createState() => _UsernameInputWidgetState();
}

class _UsernameInputWidgetState extends State<UsernameInputWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _isUsernameValid = false;
  bool _isUsernameAvailable = true; // Username availability status
  final UsernameController _usernameController = Get.put(UsernameController());

  @override
  void initState() {
    super.initState();
    _controller.text = widget.username;
    _isUsernameValid = widget.username.length >= 8;
  }

  // Function to check username availability and update status
  Future<void> _checkUsernameAvailability(String username) async {
    final exists = await _usernameController.isUsernameExists(username);
    setState(() {
      _isUsernameAvailable = !exists;
    });
  }

  // Function to display snackbar
  void _showSnackbar(String message, {bool success = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  // Function to handle confirmation
  Future<void> _handleConfirm() async {
    final success = await _usernameController.addUsername(_controller.text);
    if (success) {
      widget.onUploadStatusChanged(true); // Update upload status
      _showSnackbar('Username added successfully', success: true);
    } else {
      _showSnackbar('Failed to add username. The username may already exist.', success: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.black, width: 2.w),
          ),
          width: 300.w,
          height: 350.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Username',
                style: SatoshiTextStyle.normalStyle.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                ),
              ),
              SizedBox(height: 30.h),
              TextField(
                controller: _controller,
                onChanged: (value) {
                  setState(() {
                    _isUsernameValid = value.length >= 8;
                  });
                  // Check username availability whenever a change occurs
                  _checkUsernameAvailability(value);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: ColorsApp.textField,
                  labelText: 'Username',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorsApp.black1, width: 2.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorsApp.black1, width: 2.w),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.w),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '- Use characters and numbers only',
                    style: SatoshiTextStyle.normalStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                  Text(
                    '- Minimum 8 characters',
                    style: SatoshiTextStyle.normalStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: _controller.text.length >= 8
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  Text(
                    '- ${_isUsernameAvailable ? 'This Username is available' : 'This Username is unavailable'}',
                    style: SatoshiTextStyle.normalStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: _isUsernameAvailable ? Colors.green : Colors.red,
                    ),
                  ),
                  Text(
                    '- You can’t change your username',
                    style: SatoshiTextStyle.normalStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -25.h,
          child: GestureDetector(
            onTap: _handleConfirm,
            child: Material(
              color: Colors.transparent,
              child: ElevatedButton(
                onPressed: _isUsernameValid ? () async {
                  final success = await _usernameController.addUsername(_controller.text);
                  if (success) {
                    widget.onUploadStatusChanged(true); // Update upload status
                    _showSnackbar('Username added successfully', success: true);
                  } else {
                    _showSnackbar('Failed to add username. The username may already exist.', success: false);
                  }
                } : null, // Only disable the button if _isUsernameValid is false
                child: Text(
                  'Confirm',
                  style: SatoshiTextStyle.normalStyle.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    color: ColorsApp.black1,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsApp.green,
                  minimumSize: Size(240.w, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.black, width: 2.w),
                  ),
                  disabledBackgroundColor: ColorsApp.green,
                  foregroundColor: Colors.black,
                  disabledForegroundColor: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
