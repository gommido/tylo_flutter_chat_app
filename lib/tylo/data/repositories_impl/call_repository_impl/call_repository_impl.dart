import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/core/error/failure.dart';
import 'package:tylo/tylo/data/data_sources/remote/call_data_source/call_data_source.dart';
import 'package:tylo/tylo/data/models/call_model.dart';
import 'package:tylo/tylo/data/models/room_model.dart';
import 'package:tylo/tylo/domain/entities/room.dart';
import 'package:tylo/tylo/domain/repositories/call_repository/call_repository.dart';

import '../../../core/error/exceptions.dart';
import '../../../domain/entities/call.dart';

class CallRepositoryImpl implements CallRepository{
  CallRepositoryImpl(this.callDataSource,);
  final CallDataSource callDataSource;

  @override
  Future<Either<Failure, void>> createRoom({
    required String id,
    required String callReceiverId,
    required String callerId,
    required String callerName,
    required String callerImage,

  })async {
    try{
      final lastCallTime = Timestamp.now();
      RoomModel call = RoomModel(
        id: id,
        callReceiverId: callReceiverId,
        callerId: callerId,
        callerName: callerName,
        callerImage: callerImage,
        lastCallTime: lastCallTime,
        lastCallDuration: '0',
       isRespond: false,
      );

      final result = await callDataSource.createRoom(id: id, call: call.toJson());
      return Right(result);
    }on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> createCall({
    required String id,
    required String firstUserId,
    required String firstUserName,
    required String firstUserImage,
    required String secondUserId,
    required String secondUserName,
    required String secondUserImage,
  }) async{
    try{
      final callCreated = Timestamp.now();
      CallModel first = CallModel(
          id: id,
          secondUserId: secondUserId,
          secondUserName: secondUserName,
          secondUserImage: secondUserImage,
          callCreated: callCreated,
          isDialed: true,
        duration: 0,
      );

      CallModel second = CallModel(
        id: id,
        secondUserId: firstUserId,
        secondUserName: firstUserName,
        secondUserImage: firstUserImage,
        callCreated: callCreated,
        isDialed: false,
        duration: 0,
      );

      await callDataSource.createCall(id: id, firstUserId: firstUserId,  call: first.toJson());
      await callDataSource.createCall(id: id, firstUserId: secondUserId, call: second.toJson());

      return const Right(unit);
    }on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }


  @override
  Stream<Room?> getCallRoom({
    required String userId,
    required String field,

  }) {
    final call =  callDataSource.getCallRoom(userId: userId, field: field,).map((event){
      if (event.docs.isEmpty) return null;
      return RoomModel.fromJson(event.docs.first.data());
    });
    return call;
  }

  @override
  Future<Either<Failure, void>> updateRoomData({
    required String roomId,
    required String field,
    dynamic value,
}) async{
    try{
      final result = await callDataSource.updateRoomData(roomId: roomId, field: field, value: value,);
      return Right(result);
    }on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Stream<List<Call>> getMyCalls({required String userId}) {
    return callDataSource.getMyCalls(userId: userId).map((snapshot) {
      if(snapshot.docs.isEmpty)  return [];
      return snapshot.docs.map((doc) => CallModel.fromJson(doc.data())).toList();
    });
  }


  @override
  Future<Either<Failure, void>> updateCallData({
    required String id,
    required String callId,
    required String field,
    dynamic value,
  }) async{
    try{
      final result = await callDataSource.updateCallData(id: id, callId: callId, data: {
        field: value,
      });
      return Right(result);
    }on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteRoom({required String id}) async{
    try{
      final result = await callDataSource.deleteRoom(id: id);
      return Right(result);
    }on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCalls({required String userId, required List<String> ids})async {
    try{
      final result = await callDataSource.deleteCalls(userId: userId, ids: ids);
      return Right(result);
    }on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }






}