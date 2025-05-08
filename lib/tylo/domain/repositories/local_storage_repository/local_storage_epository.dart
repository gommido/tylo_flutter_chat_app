import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/app_contact.dart';

abstract class LocalStorageRepository{

  Future<Either<Failure, bool>> saveContactsToLocalStorage({required String key, required List<AppContact> contacts});

  Either<Failure, List<AppContact>> getContactsFromLocalStorage({required String key});


}