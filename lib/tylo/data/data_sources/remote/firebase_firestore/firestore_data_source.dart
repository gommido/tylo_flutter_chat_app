import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/resources/constants/firebase_constants.dart';
import '../../../services/firestore_service.dart';

class FireStoreDataSource{
  final FirebaseFirestore _firebaseFirestore;

  FireStoreDataSource() : _firebaseFirestore = FireBaseFireStoreService().firebaseFirestore;

  Future<void> createAppUser({
  required String id,
  required Map<String, dynamic> userData,
  }) async{
    try{
      await _firebaseFirestore.collection(FireBaseConstants.users).doc(id).set(userData);
    } on FireBaseExceptions catch(error){
      throw FireBaseFailure(message: error.errorMessage.message);
    }
  }

  Future<void> updateAppUserData({
    required String id,
    required Map<String, dynamic> userData,
  }) async{
    try{
      await _firebaseFirestore.collection(FireBaseConstants.users).doc(id).update(userData,);
    } on FireBaseExceptions catch(error){
      throw FireBaseFailure(message: error.errorMessage.message);
    }
  }


  Future<DocumentSnapshot<Map<String, dynamic>>> getUserAsFuture({required String id}) async{
    try{
      return await _firebaseFirestore.collection(FireBaseConstants.users).doc(id).get();
    } on FireBaseExceptions catch(error){
      throw FireBaseFailure(message: error.errorMessage.message);
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserAsStream({required String id,}){
    try{
      return  _firebaseFirestore.collection(FireBaseConstants.users).doc(id).snapshots();
    } on FireBaseExceptions catch(error){
      throw FireBaseFailure(message: error.errorMessage.message);
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> checkIfUserExistByField({required String field, required dynamic value,}) async{
    try{
      return await _firebaseFirestore.collection(FireBaseConstants.users).where(field, isEqualTo: value).get();
    } on FireBaseExceptions catch(error){
      throw FireBaseFailure(message: error.errorMessage.message);
    }
  }

  Future<void> deleteFirebaseDocument({
    required String collectionPath,
    required String id,
  }) async{
    await _firebaseFirestore.collection(collectionPath).doc(id).delete();
  }



  Stream<QuerySnapshot<Map<String, dynamic>>> getOnlineUsers({required List<String> ids}){
    try{
      return  _firebaseFirestore.collection(FireBaseConstants.users)
      .where(FieldPath.documentId, whereIn: ids)
          .where('lastSeen', isEqualTo: null).snapshots();
    } on FireBaseExceptions catch(error){
      throw FireBaseFailure(message: error.errorMessage.message);
    }
  }

}