import 'package:flutter/material.dart';
import 'package:history_app/config/theme/app_theme.dart';
import 'package:history_app/presentation/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'History App',
      home: const InformationScreen(),
      theme: AppTheme().getTheme(context),
    );
  }
}