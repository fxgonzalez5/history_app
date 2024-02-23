import 'package:history_app/domain/entities/entities.dart';

abstract class CloudDatabaseRepository {
  Future<int> getNumberOfHitos();
  
  Future<Hito> getHito(String hitoId);

  Future<bool> findEmail(String email);

  Future<UserEntity> getUser(String userId);

  Future<void> saveUser(UserEntity user);

  Future<void> saveHito(UserEntity user, Hito hito);
}