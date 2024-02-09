import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:history_app/domain/datasources/cloud_database_datasource.dart';
import 'package:history_app/domain/entities/hito.dart';
import 'package:history_app/infraestructure/mappers/hito_mapper.dart';
import 'package:history_app/infraestructure/models/hito_model.dart';

class FirebaseDatasource extends CloudDatabaseDatasource {
   final _db = FirebaseFirestore.instance;

  @override
  Future<Hito> getHito(String hitoId) async {
    final document = await _db.collection('hitos').doc(hitoId).get();

    if (!document.exists) throw Exception('Hito with id: $hitoId not found');

    final hitoModel = HitoModel.fromMap(document.data()!);
    return HitoMapper.hitoToEntity(hitoModel);
  }

  @override
  Future<int> getNumberOfHitos() async {
    final snapshot = await _db.collection('hitos').get();
    return snapshot.docs.length;
  }

}