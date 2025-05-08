import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/utils/message_type_enum.dart';
import '../../repositories/chat_repository/chat_repository.dart';


class DeleteMessageUseCase{
  DeleteMessageUseCase(this.chatRepository);
  final ChatRepository chatRepository;

  Future<Either<Failure, void>> deleteMessage({
    required String firstUserId,
    required String secondUserId,
    required List<String> ids,
  })async{
    return await chatRepository.deleteMessage(firstUserId: firstUserId, secondUserId: secondUserId, ids: ids);
  }
}

