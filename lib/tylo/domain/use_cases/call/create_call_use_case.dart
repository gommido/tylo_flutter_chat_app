import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/repositories/call_repository/call_repository.dart';

import '../../../core/error/failure.dart';

class CreateCallUseCase{
  CreateCallUseCase(this.callRepository);
  final CallRepository callRepository;

  Future<Either<Failure, void>> createCall({
    required String id,
    required String firstUserId,
    required String firstUserName,
    required String firstUserImage,
    required String secondUserId,
    required String secondUserName,
    required String secondUserImage,
  })async{
    return await callRepository.createCall(id: id, firstUserId: firstUserId, firstUserName: firstUserName, firstUserImage: firstUserImage, secondUserId: secondUserId, secondUserName: secondUserName, secondUserImage: secondUserImage,);
  }
}