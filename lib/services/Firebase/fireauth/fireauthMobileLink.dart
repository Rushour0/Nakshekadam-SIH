import 'package:nakshekadam/services/Firebase/firestore/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<String> linkMobile(PhoneAuthCredential credential) async {
  try {
    final userCredential =
        await _auth.currentUser?.linkWithCredential(credential);
    print(userCredential);
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case "provider-already-linked":
        return "Mobile already been linked to the user.";
      case "invalid-credential":
        return "Credential is not valid.";
      case "credential-already-in-use":
        return "Number already linked to a Firebase User.";
      // See the API reference for the full list of error codes.
      default:
        return "Unknown error.";
    }
  }
  updateInitialData();

  return "0";
}

void updateInitialData() async {
  CollectionReference users = usersCollectionReference();
  await users.doc(_auth.currentUser!.uid).set({
    "phone": _auth.currentUser!.phoneNumber,
  }, SetOptions(merge: true));
}
