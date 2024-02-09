import 'package:history_app/domain/entities/hito.dart';

abstract class CloudDatabaseDatasource {
  Future<int> getNumberOfHitos();
  
  Future<Hito> getHito(String hitoId);
}