import 'package:tylo/tylo/data/data_sources/remote/chat_data_source/chat_data_source.dart';
import 'package:tylo/tylo/domain/entities/chat_message.dart';
import 'package:tylo/tylo/domain/entities/group.dart';
import 'package:tylo/tylo/domain/repositories/chat_repository/chat_repository.dart';
import 'package:tylo/tylo/domain/repositories/group_repository/group_repository.dart';

class GetMyGroupsUseCase{
  GetMyGroupsUseCase(this.groupRepository);
  final GroupRepository groupRepository;

  Stream<List<Group>> getMyGroups({required String id}){
    return groupRepository.getMyGroups(id: id);
  }

}