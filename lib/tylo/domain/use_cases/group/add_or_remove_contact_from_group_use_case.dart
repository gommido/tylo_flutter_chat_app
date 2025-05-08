
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../repositories/group_repository/group_repository.dart';

class AddOrRemoveContactFromGroupUseCase{
  AddOrRemoveContactFromGroupUseCase(this.groupRepository);
  final GroupRepository groupRepository;

  Future<Either<Failure, void>> addOrRemoveContactFromGroup({
    required String groupId,
    required List<String> members,
    required bool isAdding,
  })async{
    return await groupRepository.addOrRemoveContactFromGroup(groupId: groupId, members: members, isAdding: isAdding,);
  }

}