part of 'firestorage_cubit.dart';

@immutable
abstract class FireStorageState {}

class FireStorageInitial extends FireStorageState {}

class UploadFileToFireStorageLoadingState extends FireStorageState {}
class UploadFileToFireStorageSuccessState extends FireStorageState {}
class UploadFileToFireStorageFailureState extends FireStorageState {
  final String error;
  UploadFileToFireStorageFailureState(this.error);
}

class DeleteStoredFileSuccessState extends FireStorageState {}
class DeleteStoredFileFailureState extends FireStorageState {
  final String error;
  DeleteStoredFileFailureState(this.error);
}
