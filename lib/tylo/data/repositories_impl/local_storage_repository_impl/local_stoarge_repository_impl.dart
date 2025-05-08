import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/data/data_sources/local/local_storage_data_source.dart';
import 'package:tylo/tylo/data/models/app_contact_model.dart';
import 'package:tylo/tylo/domain/entities/app_contact.dart';
import 'package:tylo/tylo/domain/repositories/local_storage_repository/local_storage_epository.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failure.dart';

class LocalStorageRepositoryImpl implements LocalStorageRepository{
  LocalStorageRepositoryImpl(this._localStorageDataSource);
  final LocalStorageDataSource _localStorageDataSource;

  @override
  Future<Either<Failure, bool>> saveContactsToLocalStorage({required String key,  required List<AppContact> contacts})async {
    try{
      final data = contacts.map((e){
        AppContactModel appContactModel = AppContactModel(id: e.id, name: e.name, phone: e.phone, image: e.image, photoVisibility: e.photoVisibility, whoBlockMeList: e.whoBlockMeList);
        return appContactModel.toJson();
      }).toList();
      final result = await _localStorageDataSource.saveContactsToLocalStorage(key: key, mapList: data);
      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(LocalFailure(message: error.errorMessage.message));
    }
  }

  @override
  Either<Failure, List<AppContact>> getContactsFromLocalStorage({required String key}) {
    try{
      final data =  _localStorageDataSource.getContactsFromLocalStorage(key: key);
      final result =  data.map((e) => AppContactModel.fromJson(e)).toList();
      return Right(result);
    }on FireBaseExceptions catch(error){
      return Left(LocalFailure(message: error.errorMessage.message));
    }
  }

  
}