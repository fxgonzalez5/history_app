import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:history_app/domain/entities/user_entity.dart';
import 'package:history_app/infraestructure/repositories/cloud_database_repository_impl.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> authStatus() {
    return _auth.authStateChanges();
  }

  Future<bool> createAccount(String email, String password) async {
    try {
      final emailExiste = await Get.find<CloudDatabaseRepositoryImpl>().findEmail(email);

      if (emailExiste) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        final UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final userEntity = UserEntity(
          id: credential.user!.uid,
          email: email,
          name: 'Nombre y Apellido', // TODO: Cambiar por el nombre del usuario
          photoUrl: null // TODO: Cambiar por la url de la foto del usuario
        );

        Get.find<CloudDatabaseRepositoryImpl>().saveUser(userEntity);
      }

      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> signInWithMicrosoft(String email) async {
    try {
      final microsoftProvider = MicrosoftAuthProvider();
      final credential = await _auth.signInWithProvider(
        microsoftProvider.setCustomParameters({
        // 'login_hint': email,
        // 'prompt': 'login',
        })
      );
      
      final emailExiste = await Get.find<CloudDatabaseRepositoryImpl>().findEmail(email);
      if (!emailExiste) {
        final userEntity = UserEntity(
          id: credential.user!.uid,
          email: credential.user!.email!,
          name: credential.user!.displayName!,
          photoUrl: credential.user!.photoURL
        );
        
        Get.find<CloudDatabaseRepositoryImpl>().saveUser(userEntity); 
      }
      
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}