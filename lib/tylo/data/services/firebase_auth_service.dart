import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuthService {
  static final FireBaseAuthService _instance = FireBaseAuthService._internal();
  final FirebaseAuth firebaseAuth;

  factory FireBaseAuthService() {
    return _instance;
  }

  FireBaseAuthService._internal() : firebaseAuth = FirebaseAuth.instance;
}
