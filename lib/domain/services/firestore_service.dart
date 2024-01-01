import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:history_app/infraestructure/models/hito_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<int> getNumberOfHitos() async {
    QuerySnapshot snapshot = await _firestore.collection('hitos').get();
    return snapshot.docs.length;
  }

  Future<HitosModel> getHito(String id) async {
    DocumentSnapshot snapshot = await _firestore.collection('hitos').doc(id).get();
    return HitosModel.fromMap(snapshot.data() as Map<String, dynamic>);
  }
}