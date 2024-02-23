import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:history_app/config/firebase/firebase_options.dart';
import 'package:history_app/config/routes/app_route.dart';
import 'package:history_app/config/theme/app_theme.dart';
import 'package:history_app/infraestructure/datasources/firebase_datasource.dart';
import 'package:history_app/infraestructure/repositories/cloud_database_repository_impl.dart';
import 'package:history_app/presentation/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

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
      initialBinding: MainBinding(),
    );
  }
}

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CloudDatabaseRepositoryImpl(FirebaseDatasource()));
    Get.put(UserController());
    Get.put(NavigationController());
  }
}