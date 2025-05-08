
import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/entities/group.dart';

import '../../../core/error/failure.dart';
import '../../entities/app_user.dart';
import '../../repositories/group_repository/group_repository.dart';

class GetGroupDetailsUseCase{
  GetGroupDetailsUseCase(this.groupRepository);
  final GroupRepository groupRepository;

  Stream<Group?> getGroupDetails({
    required String id,
  }){
    return groupRepository.getGroupDetails(id: id,);
  }

}