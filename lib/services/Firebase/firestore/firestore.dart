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
    'name': user.displayName ??
        "${(temp['firstName'] as String)} ${(temp['lastName'] as String)}",
    'uid': user.uid,
    'clientType': temp['question'] > 0 ? 'student' : 'parent',
    'type': temp['question'],
    'photoURL': user.photoURL,
    'testStatus': (temp['testGiven'] as List).map((e) {
      return e;
    }).toList(),
  };
  data.putIfAbsent('standard', () => '');
  print(temp);
  await userDocumentReference()
      .collection('data')
      .doc('userInfo')
      .get()
      .then((value) {
    data['standard'] = value.data()!['class/grade'];
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
  await firestore
      .collection('all_requests')
      .doc(professionalId)
      .collection('requests')
      .doc(userId)
      .set(data, SetOptions(merge: true));
  return;
}

Future<void> requestStatusUpdate({required String userId}) async {
  await firestore
      .collection('all_requests')
      .doc(userId)
      .collection('requests')
      .doc(getCurrentUserId())
      .update({
    'requestStatus': 'reported',
  });

  await usersCollectionReference()
      .doc(getCurrentUserId())
      .collection('requests')
      .doc(userId)
      .update({
    'requestStatus': 'reported',
  });
}
