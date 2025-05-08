import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseFireStoreService {
  static final FireBaseFireStoreService _instance = FireBaseFireStoreService._internal();
  final FirebaseFirestore firebaseFirestore;

  factory FireBaseFireStoreService() {
    return _instance;
  }

  FireBaseFireStoreService._internal() : firebaseFirestore = FirebaseFirestore.instance;
}
