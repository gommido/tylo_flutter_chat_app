import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../entities/app_user.dart';

abstract class FireStoreRepository{

  Future<Either<Failure, void>> createAppUser({
    required String id,
    required String name,
    required String phone,
    required String photo,
    required String token,
  });

  Future<Either<Failure, void>> updateAppUserData({
    required String id,
    required String field,
    dynamic value,
  });

  Future<Either<Failure, AppUser?>> checkIfUserExistByField({required String field, required dynamic value,});

  Future<Either<Failure, AppUser?>> getUserAsFuture({
    required String id,
  });

  Stream<AppUser?> getUserAsStream({
    required String id,
  });

  Future<Either<Failure, void>> deleteFirebaseDocument({
    required String collectionPath,
    required String id,
  });

  Future<Either<Failure, void>> updateBlockContactStatus({
    required String id,
    required String blockedId,
    required bool isBlocking,
  });

  Stream<List<AppUser>> getOnlineUsers({required List<String> ids});

}
