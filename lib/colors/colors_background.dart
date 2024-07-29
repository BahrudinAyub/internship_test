import 'package:flutter/material.dart';
import 'colors_app.dart'; // Pastikan untuk mengimpor class ColorsApp yang telah Anda buat

class BackgroundColor {
  static const LinearGradient gradient = LinearGradient(
    colors: [
      ColorsApp.background1,
      ColorsApp.background2,
      ColorsApp.background3,
      ColorsApp.background4,
      ColorsApp.background5,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
