import 'package:tylo/tylo/data/data_sources/remote/chat_data_source/chat_data_source.dart';
import 'package:tylo/tylo/domain/entities/chat_message.dart';
import 'package:tylo/tylo/domain/entities/last_message.dart';
import 'package:tylo/tylo/domain/repositories/chat_repository/chat_repository.dart';

class GetUnseenNewChatsCountUseCase{
  GetUnseenNewChatsCountUseCase(this.chatRepository);
  final ChatRepository chatRepository;

  Stream<List<LastMessage>> getUnSeenNewChatsCount({required String userId}){
    return chatRepository.getUnSeenNewChatsCount(userId: userId);
  }

}

