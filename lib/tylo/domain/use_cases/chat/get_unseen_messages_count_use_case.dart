import '../../entities/chat_message.dart';
import '../../repositories/chat_repository/chat_repository.dart';

class GetUnseenMessagesCountUseCase{
  GetUnseenMessagesCountUseCase(this.chatRepository);
  final ChatRepository chatRepository;

  Stream<List<ChatMessage>> getUnSeenMessagesCount({
    required String senderId,
    required String receiverId,
  }){
    return chatRepository.getUnSeenMessagesCount(senderId: senderId, receiverId: receiverId, );
  }
}