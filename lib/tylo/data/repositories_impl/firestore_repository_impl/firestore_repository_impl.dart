import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/app_user.dart';
import '../../../domain/repositories/firestore_repository/firestore_repository.dart';
import '../../data_sources/remote/firebase_firestore/firestore_data_source.dart';
import '../../models/app_user_model.dart';

class FireStoreRepositoryImpl implements FireStoreRepository{
  FireStoreRepositoryImpl(this._fireStoreDataSource);
  final FireStoreDataSource _fireStoreDataSource;

  @override
  Future<Either<Failure, void>> createAppUser({
    required String id,
    required String name,
    required String phone,
    required String photo,
    required String token,
  }) async{
    try{
      AppUserModel newUserModel = AppUserModel(
        id: id,
        name: name,
        phone: phone,
        photo: photo,
        bio: 'This is my bio..',
        lastSeen: null,
        createdAt: Timestamp.now(),
        token: token,
        currentChatRoom: '',
        isTyping: false,
        blockList: [],
        contacts: [],
        onlineVisibility: 'My contacts',
        photoVisibility: 'My contacts',
        whoBlockMeList: [],
      );
      final result =  await _fireStoreDataSource.createAppUser(id: id, userData: newUserModel.toJson());
      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateAppUserData({
    required String id,
    required String field,
    dynamic value,
  })async {
    try{
      final result =  await _fireStoreDataSource.updateAppUserData(
          id: id,
          userData: {
            field: value,
          });
      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Future<Either<Failure, AppUser?>> getUserAsFuture({required String id,})async{
    try{
      final data =  await _fireStoreDataSource.getUserAsFuture(id: id,);
      final result = AppUserModel.fromJson(data.data()!);
      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Stream<AppUser?> getUserAsStream({required String id}) {
    try{
      final userData = _fireStoreDataSource.getUserAsStream(id: id).map((event){
        return AppUserModel.fromJson(event.data() as Map<String, dynamic>);
      });
      return userData;
    } on FireBaseExceptions catch(error){
      return Stream.value(FireBaseFailure(message: error.errorMessage.message) as AppUser);
    }
  }


  @override
  Future<Either<Failure, AppUser?>> checkIfUserExistByField({required String field, required dynamic value,}) async{
    try{
      final data =  await _fireStoreDataSource.checkIfUserExistByField(field: field, value: value);
      final result = data.docs.map((e) => AppUserModel.fromJson(e.data())).toList();
      if(result.isNotEmpty){
        return Right(result.first);
      }else{
        return const Right(null);
      }
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFirebaseDocument({required String collectionPath, required String id}) async {
    try{
      final result =  await _fireStoreDataSource.deleteFirebaseDocument(collectionPath: collectionPath, id: id);
      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateBlockContactStatus({
    required String id,
    required String blockedId,
    required bool isBlocking,
  }) async {
    try{
      if(isBlocking){
        final result =  await _fireStoreDataSource.updateAppUserData(
            id: id,
            userData: {
              'blockList': FieldValue.arrayUnion([blockedId]),
            });
        return Right(result);
      }else{
        final result =  await _fireStoreDataSource.updateAppUserData(
            id: id,
            userData: {
              'blockList': FieldValue.arrayRemove([blockedId]),
            });
        return Right(result);
      }
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Stream<List<AppUser>> getOnlineUsers({required List<String> ids}) {
    return _fireStoreDataSource.getOnlineUsers(ids: ids,).map((snapshot) {
      if(snapshot.docs.isEmpty){
        return [];
      }
      return snapshot.docs.where((doc) => doc['lastSeen'] == null)
          .map((doc) => AppUserModel.fromJson(doc.data())).toList();
    });
  }



}