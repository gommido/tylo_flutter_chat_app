import 'package:tylo/tylo/data/data_sources/remote/chat_data_source/chat_data_source.dart';
import 'package:tylo/tylo/domain/entities/chat_message.dart';
import 'package:tylo/tylo/domain/entities/last_message.dart';
import 'package:tylo/tylo/domain/repositories/chat_repository/chat_repository.dart';

class GetMyChatsLastMessagesUseCase{
  GetMyChatsLastMessagesUseCase(this.chatRepository);
  final ChatRepository chatRepository;

  Stream<List<LastMessage>> getMyChatsLastMessages({required String userId}){
    return chatRepository.getMyChatsLastMessages(userId: userId);
  }

}

