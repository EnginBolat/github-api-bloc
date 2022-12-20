import 'package:flutter/material.dart';
import 'package:github_api_app/constants/app_text.dart';
import 'package:github_api_app/view/home_page.dart';

import 'constants/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppText.appName,
      theme: AppTheme().lightTheme,
      home: HomePage(),
    );
  }
}
