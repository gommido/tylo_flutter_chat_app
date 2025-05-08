import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/repositories/group_repository/group_repository.dart';

import '../../../core/error/failure.dart';
import '../../../core/utils/message_type_enum.dart';
import '../../repositories/chat_repository/chat_repository.dart';


class DeleteGroupMessageUseCase{
  DeleteGroupMessageUseCase(this.groupRepository);
  final GroupRepository groupRepository;

  Future<Either<Failure, void>> deleteGroupMessage({
    required String groupId,
    required List<String> ids,
  })async{
    return await groupRepository.deleteGroupMessage(groupId: groupId, ids: ids);
  }
}

