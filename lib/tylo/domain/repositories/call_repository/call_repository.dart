import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/entities/call.dart';

import '../../../core/error/failure.dart';
import '../../entities/room.dart';

abstract class CallRepository{

  Future<Either<Failure, void>> createRoom({
    required String id,
    required String callReceiverId,
    required String callerId,
    required String callerName,
    required String callerImage,
  });

  Future<Either<Failure, void>> createCall({
    required String id,
    required String firstUserId,
    required String firstUserName,
    required String firstUserImage,
    required String secondUserId,
    required String secondUserName,
    required String secondUserImage,
  });

  Stream<Room?> getCallRoom({
    required String userId,
    required String field,
  });

  Future<Either<Failure, void>> updateRoomData({
    required String roomId,
    required String field,
    dynamic value,
  });

  Stream<List<Call>> getMyCalls({required String userId});


  Future<Either<Failure, void>> updateCallData({
    required String id,
    required String callId,
    required String field,
    dynamic value,
  });

  Future<Either<Failure, void>> deleteRoom({
    required String id,
  });

  Future<Either<Failure, void>> deleteCalls({
    required String userId,
    required List<String> ids,
  });


}