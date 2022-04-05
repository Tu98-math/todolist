import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

CollectionReference user = FirebaseFirestore.instance.collection('users');

final getUserDataStream =
    StreamProvider<QuerySnapshot>((ref) => user.snapshots());
