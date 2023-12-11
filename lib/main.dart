import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:history_app/config/routes/app_route.dart';
import 'package:history_app/config/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'History App',
      initialRoute: initialPage,
      getPages: appRouter,
      theme: AppTheme().getTheme(context),
    );
  }
}