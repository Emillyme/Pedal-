import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final userId = FirebaseAuth.instance.currentUser?.uid;

final desafiosRef = FirebaseFirestore.instance
  .collection('usuarios')
  .doc(userId)
  .collection('desafios');

  