import 'package:tylo/tylo/data/data_sources/remote/chat_data_source/chat_data_source.dart';
import 'package:tylo/tylo/domain/entities/chat_message.dart';
import 'package:tylo/tylo/domain/entities/group_message.dart';
import 'package:tylo/tylo/domain/repositories/chat_repository/chat_repository.dart';
import 'package:tylo/tylo/domain/repositories/group_repository/group_repository.dart';

class GetGroupMessagesUseCase{
  GetGroupMessagesUseCase(this.groupRepository);
  final GroupRepository groupRepository;

  Stream<List<GroupMessage>> getChatMessages({required String groupId}){
    return groupRepository.getGroupMessages(groupId: groupId );
  }

}