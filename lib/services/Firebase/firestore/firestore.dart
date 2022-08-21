import 'package:nakshekadam/services/Firebase/FireAuth/fireauth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference userDocumentCollection({required String collection}) {
  return firestore
      .collection('users')
      .doc(getCurrentUserId())
      .collection(collection);
}

CollectionReference usersCollectionReference() {
  return firestore.collection('users');
}

DocumentReference<Map<String, dynamic>> userDocumentReference() {
  return firestore.collection('users').doc(getCurrentUserId());
}

Future<void> deleteDocumentByReference(DocumentReference reference) async {
  await firestore.runTransaction(
      (Transaction transaction) async => transaction.delete(reference));
}
