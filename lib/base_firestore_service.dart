abstract class BaseFirestoreService {
  Future addDataToFirestore(Map<String, dynamic> data, String coll, String doc);
  Future updateDataToFirestore(
      Map<String, dynamic> data, String coll, String doc);
  Future getUserData(String coll, String doc);
}
