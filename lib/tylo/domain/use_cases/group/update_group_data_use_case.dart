import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/repositories/group_repository/group_repository.dart';

import '../../../core/error/failure.dart';

class UpdateGroupDataUseCase{
  UpdateGroupDataUseCase(this.groupRepository);
  final GroupRepository groupRepository;

  Future<Either<Failure, void>> updateAppUserData({
    required String id,
    required String field,
    dynamic value,
  })async{
    return await groupRepository.updateGroupData(id: id, field: field, value: value);
  }
}