import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poultry_hisab/applications/theme.dart';
import 'package:poultry_hisab/screens/auth.dart';

class PoultryHisab extends StatelessWidget {
  const PoultryHisab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: Themes().lightTheme,
      home: AuthCheck(),
    );
  }
}
