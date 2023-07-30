import 'package:auth/base_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService extends BaseFirestoreService {
  final _firestoreInstance = FirebaseFirestore.instance;

  @override
  Future addDataToFirestore(
      Map<String, dynamic> data, String coll, String doc) async {
    try {
      await _firestoreInstance.collection(coll).doc(doc).set(data);
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  @override
  Future updateDataToFirestore(
      Map<String, dynamic> data, String coll, String doc) async {
    try {
      await _firestoreInstance.collection(coll).doc(doc).update(data);
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  @override
  Future getUserData(String coll, String doc) async {
    try {
      final userData = await _firestoreInstance.collection(coll).doc(doc).get();
      return userData;
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }
}
