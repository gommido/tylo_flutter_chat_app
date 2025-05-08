import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/repositories/local_storage_repository/local_storage_epository.dart';

import '../../../core/error/failure.dart';
import '../../entities/app_contact.dart';

class GetContactsFromLocalStorageUseCase{
  GetContactsFromLocalStorageUseCase(this._localStorageRepository);
  final LocalStorageRepository _localStorageRepository;

  Either<Failure, List<AppContact>> getContactsFromLocalStorage({required String key}){
    return _localStorageRepository.getContactsFromLocalStorage(key: key);
  }
}