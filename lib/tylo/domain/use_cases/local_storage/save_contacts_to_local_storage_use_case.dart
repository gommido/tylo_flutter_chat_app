import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/entities/app_contact.dart';
import 'package:tylo/tylo/domain/repositories/local_storage_repository/local_storage_epository.dart';

import '../../../core/error/failure.dart';

class SaveContactsToLocalStorageUseCase{
  SaveContactsToLocalStorageUseCase(this._localStorageRepository);
  final LocalStorageRepository _localStorageRepository;

  Future<Either<Failure, bool>> saveContactsToLocalStorage({required String key, required List<AppContact> contacts})async{
    return await _localStorageRepository.saveContactsToLocalStorage(key: key, contacts: contacts);
  }
}