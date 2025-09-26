import 'package:flutter/material.dart';

/// Các hằng số của ứng dụng
class AppConstants {
  // App Info
  static const String appName = 'Notes Manager';
  static const String appVersion = '1.0.0';

  // UI Constants
  static const double sidebarWidth = 300.0;
  static const double borderRadius = 8.0;
  static const double cardPadding = 12.0;
  static const double sectionSpacing = 20.0;

  // Colors
  static const Color primaryColor = Colors.blue;
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardColor = Colors.white;
  static const Color borderColor = Color(0xFFE0E0E0);

  // Text Styles
  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
  );

  static const TextStyle captionStyle = TextStyle(
    fontSize: 12,
    color: Colors.grey,
  );

  // Validation
  static const int maxTitleLength = 200;
  static const int maxContentLength = 10000;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
}
