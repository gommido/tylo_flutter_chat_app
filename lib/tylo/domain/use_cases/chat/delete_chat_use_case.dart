import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/utils/message_type_enum.dart';
import '../../repositories/chat_repository/chat_repository.dart';


class DeleteChatUseCase{
  DeleteChatUseCase(this.chatRepository);
  final ChatRepository chatRepository;

  Future<Either<Failure, void>> deleteChat({
    required String firstUserId,
    required String secondUserId,
  })async{
    return await chatRepository.deleteChat(firstUserId: firstUserId, secondUserId: secondUserId);
  }
}

