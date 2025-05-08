import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/utils/message_type_enum.dart';
import '../../repositories/chat_repository/chat_repository.dart';


class DeleteChatLastMessagesUseCase{
  DeleteChatLastMessagesUseCase(this.chatRepository);
  final ChatRepository chatRepository;

  Future<Either<Failure, void>> deleteChatLastMessages({
    required String userId,
    required List<String> ids,
  })async{
    return await chatRepository.deleteChatLastMessages(userId: userId, ids: ids);
  }
}

