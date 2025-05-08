import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../services/firebase_auth_service.dart';

class FireBaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;

  FireBaseAuthDataSource() : _firebaseAuth = FireBaseAuthService().firebaseAuth;

  late String _verificationId;
  int? _resendingToken;

  Future<void> signUpWithPhoneNumber({required String phoneNumber}) async {
    try{
       await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException error) {  },
        codeSent: (String verificationId, int? forceResendingToken) {
          _verificationId = verificationId;
          _resendingToken = forceResendingToken;

        },
        codeAutoRetrievalTimeout: (String verificationId) {  },
        timeout: const Duration(seconds: 30),
         forceResendingToken: _resendingToken,

       );
    } on FireBaseExceptions catch(error){
      throw FireBaseFailure(message: error.errorMessage.message);
    }
  }

  Future<void> verifyNumber({required String smsCode}) async{
    try{
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId,
          smsCode: smsCode,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on FireBaseExceptions catch(error){
      throw FireBaseFailure(message: error.errorMessage.message);

    }
  }

  String? getCurrentUserId(){
    try{
      return _firebaseAuth.currentUser!.uid;
    } on FireBaseExceptions catch(error){
      throw FireBaseFailure(message: error.errorMessage.message);
    }
  }

  Future<User?> signInWithGoogleAccount()async {
    User? user;
    try{
      const List<String> scopes = <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ];
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: scopes,
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        user = userCredential.user;
      }
      return user;
    } on FireBaseExceptions catch(error){
      throw FireBaseFailure(message: error.errorMessage.message);
    }
  }

  /*
  Future<User?> signInWithFacebookAccount()async {
    User? user;
    try{
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        AccessToken? accessToken = result.accessToken;
        if(accessToken != null){
          final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.tokenString);
          final userCredential =  await FirebaseAuth.instance.signInWithCredential(credential);
          user = userCredential.user;
        }
      }
      return user;
    } on FireBaseExceptions catch(error){
      throw FireBaseFailure(message: error.errorMessage.message);
    }
  }

   */

}