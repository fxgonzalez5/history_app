import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_app/domain/entities/entities.dart';
import 'package:history_app/infraestructure/repositories/cloud_database_repository_impl.dart';
import 'package:history_app/presentation/screens/screens.dart';
import 'package:history_app/presentation/services/firebase_auth_service.dart';

part 'user_controller.dart';

class CheckAuthScreen extends GetView<UserController> {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseAuthService = FirebaseAuthService();

    return Scaffold(
      body: StreamBuilder(
        stream: firebaseAuthService.authStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          
          if (snapshot.connectionState == ConnectionState.active){
            if (snapshot.hasData) {
              return FutureBuilder(
                future: controller.loadUser(snapshot.data!.uid),
                builder: (context, snapshot) {
                  return const NavigationPage();
                },
              );
            }
          }
          
          return const LoginPage();
        }, 
      )
   );
  }
}