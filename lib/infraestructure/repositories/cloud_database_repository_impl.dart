import 'package:history_app/domain/datasources/cloud_database_datasource.dart';
import 'package:history_app/domain/entities/hito.dart';
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

}