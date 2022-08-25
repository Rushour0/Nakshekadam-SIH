import 'package:age_calculator/age_calculator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nakshekadam/services/Firebase/fireauth/fireauth.dart';

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

Future<void> sendRequest({
  required String professionalId,
  required String userId,
}) async {
  Map<String, dynamic> temp = (await userDocumentReference().get()).data()!;
  User user = getCurrentUser()!;

  Map<String, dynamic> data = {
    getCurrentUserId(): {
      'name': user.displayName ??
          "${(temp['firstName'] as String)} ${(temp['lastName'] as String)}",
      'clientType': temp['question'] > 0 ? 'student' : 'parent',
      'type': temp['question'],
      'photoURL': user.photoURL,
      'standard': temp['standard'],
      'specialisation': temp['specialisation'],
      'universityName': temp['universityName'],
    }
  };
  userDocumentReference()
      .collection('data')
      .doc('userInfo')
      .get()
      .then((value) {
    data.putIfAbsent('standard', () => value['class/grade']);
  });

  await userDocumentCollection(collection: 'requests').doc(professionalId).set({
    'userId': userId,
    'requestStatus': 'pending',
    'photoURL': user.photoURL,
  });
  await firestore
      .collection('all_requests')
      .doc(professionalId)
      .collection('requests')
      .doc(userId)
      .set({
    'requestStatus': 'pending',
  });
  return;
}
