
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../repositories/group_repository/group_repository.dart';

class CreateGroupUseCase{
  CreateGroupUseCase(this.groupRepository);
  final GroupRepository groupRepository;

  Future<Either<Failure, void>> createGroup({
    required String id,
    required String name,
    required String ownerId,
    required String ownerName,
    required String ownerImage,
    required String image,
    required List<String> membersIds,
  })async{
    return await groupRepository.createGroup(id: id, name: name, ownerId: ownerId, ownerName: ownerName, ownerImage: ownerImage, image: image, membersIds: membersIds,);
  }

}