import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/fire_store_services.dart';
import 'auth_provider.dart';

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final firestoreServicesProvider = Provider<FirestoreService>((ref) {
  return FirestoreService(ref.read(firebaseFirestoreProvider));
});

final quickFirebaseFirestoreProvider = Provider<CollectionReference?>((ref) {
  dynamic auth = ref.watch(authServicesProvider);
  User? user = auth.currentUser();
  if (user != null) {
    return FirebaseFirestore.instance
        .collection('user')
        .doc(user.uid)
        .collection('quick_note');
  }
  return null;
});

final projectFirebaseFirestoreProvider = Provider<CollectionReference>((ref) {
  return FirebaseFirestore.instance.collection('project');
});
