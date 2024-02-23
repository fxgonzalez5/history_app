import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:history_app/domain/entities/entities.dart';
import 'package:history_app/domain/datasources/cloud_database_datasource.dart';
import 'package:history_app/infraestructure/mappers/mappers.dart';
import 'package:history_app/infraestructure/models/models.dart';

class FirebaseDatasource extends CloudDatabaseDatasource {
   final _db = FirebaseFirestore.instance;

  @override
  Future<Hito> getHito(String hitoId) async {
    const pattern = r'^[a-zA-Z0-9\-_]+$';
    final regExp = RegExp(pattern);

    if (hitoId.length != 20 || !regExp.hasMatch(hitoId)) throw Exception('Código no válido');

    final document = await _db.collection('hitos').doc(hitoId).get();

    if (!document.exists) throw Exception('Hito no encontrado');

    final hitoModel = HitoModel.fromMap(document.data()!);
    return HitoMapper.hitoToEntity(hitoModel);
  }

  @override
  Future<int> getNumberOfHitos() async {
    final snapshot = await _db.collection('hitos').get();
    return snapshot.docs.length;
  }

   @override
  Future<bool> findEmail(String email) async {
    final snapshot = await _db.collection('utpl').where('email', isEqualTo: email).get();
    return snapshot.docs.isNotEmpty;
  }

  @override
  Future<UserEntity> getUser(String userId) async {
    final snapshot = await _db.collection('utpl').doc(userId).get();
    return UserMapper.userToEntity(UserModel.fromMap(snapshot.data()!));
  }

  @override
  Future<void> saveUser(UserEntity user) async {
    await _db.collection('utpl').doc(user.id).set(UserMapper.entityToModel(user).toMap());
  }

  @override
  Future<void> saveHito(UserEntity user, Hito hito) async {
    await _db.collection('utpl').doc(user.id).update({
      'hitos': FieldValue.arrayUnion([HitoMapper.entityToModel(hito).toMap()])
    });
  }
}