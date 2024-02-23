import 'package:history_app/domain/entities/entities.dart';
import 'package:history_app/domain/datasources/cloud_database_datasource.dart';
import 'package:history_app/domain/repositories/cluod_database_repository.dart';

class CloudDatabaseRepositoryImpl extends CloudDatabaseRepository {
  final CloudDatabaseDatasource datasource;

  CloudDatabaseRepositoryImpl(this.datasource);

  @override
  Future<Hito> getHito(String hitoId) {
    return datasource.getHito(hitoId);
  }

  @override
  Future<int> getNumberOfHitos() {
    return datasource.getNumberOfHitos();
  }

   @override
  Future<bool> findEmail(String email) {
    return datasource.findEmail(email);
  } 

  @override
  Future<UserEntity> getUser(String userId) {
    return datasource.getUser(userId);
  }

  @override
  Future<void> saveUser(UserEntity user) {
    return datasource.saveUser(user);
  }

  @override
  Future<void> saveHito(UserEntity user, Hito hito) {
    return datasource.saveHito(user, hito);
  }
}