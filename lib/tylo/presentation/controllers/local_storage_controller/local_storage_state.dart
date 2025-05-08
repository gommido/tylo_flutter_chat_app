part of 'local_storage_cubit.dart';

@immutable
abstract class LocalStorageState {}

class LocalStorageInitial extends LocalStorageState {}

class SaveContactsToLocalStorageSuccessState extends LocalStorageState {}
class SaveContactsToLocalStorageFailureState extends LocalStorageState {
  final String error;
  SaveContactsToLocalStorageFailureState(this.error);
}

class GetContactsFromLocalStorageSuccessState extends LocalStorageState {}
class GetContactsFromLocalStorageFailureState extends LocalStorageState {
  final String error;
  GetContactsFromLocalStorageFailureState(this.error);
}

class GetStoredContactNameState extends LocalStorageState {}

class SearchForContactsState extends LocalStorageState {}
