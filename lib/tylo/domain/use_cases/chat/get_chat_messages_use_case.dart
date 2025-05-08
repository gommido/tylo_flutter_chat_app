import 'package:tylo/tylo/data/data_sources/remote/chat_data_source/chat_data_source.dart';
import 'package:tylo/tylo/domain/entities/chat_message.dart';
import 'package:tylo/tylo/domain/repositories/chat_repository/chat_repository.dart';

class GetChatMessagesUseCase{
  GetChatMessagesUseCase(this.chatRepository);
  final ChatRepository chatRepository;

  Stream<List<ChatMessage>> getChatMessages({
    required String sentBy,
    required String sentTo,
  }){
    return chatRepository.getChatMessages(sentBy: sentBy, sentTo: sentTo,);
  }

}