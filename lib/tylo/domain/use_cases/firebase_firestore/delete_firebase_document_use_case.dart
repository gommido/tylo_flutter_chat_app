import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../repositories/firestore_repository/firestore_repository.dart';

class DeleteFirebaseDocumentUseCase{
  DeleteFirebaseDocumentUseCase(this.fireStoreRepository);
  final FireStoreRepository fireStoreRepository;

  Future<Either<Failure, void>> deleteFirebaseDocument({
    required String collectionPath,
    required String id,
  })async{
    return await fireStoreRepository.deleteFirebaseDocument(collectionPath: collectionPath, id: id);
  }
}