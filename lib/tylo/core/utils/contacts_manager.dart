import 'package:dartz/dartz.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../error/exceptions.dart';
import '../error/failure.dart';

class ContactsManager {

  Future<Either<Failure, List<Contact>>> getPhoneContacts()async {
    try{
      final result = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      return Right(result);
    } on LocalExceptions catch(error){
      return Left(LocalFailure(message: error.errorMessage.message));
    }
  }

  Future<Either<Failure, Contact>> insertContact({required Contact contact})async {
    try{
      final result = await FlutterContacts.insertContact(contact);
      return Right(result);
    } on LocalExceptions catch(error){
      return Left(LocalFailure(message: error.errorMessage.message));
    }
  }

}