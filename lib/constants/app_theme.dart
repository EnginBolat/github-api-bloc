import 'package:flutter/material.dart';
import 'package:github_api_app/constants/app_radius.dart';

class AppTheme {
  ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.minValue),
      ),
    ),
  );
}
