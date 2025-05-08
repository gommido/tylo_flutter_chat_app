import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/repositories/group_repository/group_repository.dart';

import '../../../core/error/failure.dart';

class UpdateGroupMessageUseCase{
  UpdateGroupMessageUseCase(this._groupRepository);
  final GroupRepository _groupRepository;

  Future<Either<Failure, void>> updateGroupMessage({
    required String groupId,
    required String messageId,
    required String field,
    String? value,
  })async {
    return await _groupRepository.updateGroupMessage(groupId: groupId, messageId: messageId, field: field, value: value,);
  }
}