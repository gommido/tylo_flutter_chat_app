import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../domain/use_cases/firebase_storage/delete_stored_file_usecase.dart';
import '../../../domain/use_cases/firebase_storage/upload_file_usecase.dart';

part 'firestorage_state.dart';

class FireStorageCubit extends Cubit<FireStorageState> {
  FireStorageCubit(this._uploadFileToFireStorageUseCase, this._deleteStoredFileUseCase) : super(FireStorageInitial());
  final UploadFileToFireStorageUseCase _uploadFileToFireStorageUseCase;
  final DeleteStoredFileUseCase _deleteStoredFileUseCase;

  late String fileUrl;

  Future<String> uploadFileToFireStorage({required String folder, required File file})async{
    emit(UploadFileToFireStorageLoadingState());
    final result = await _uploadFileToFireStorageUseCase.uploadFileToFireStorage(folder: folder, file: file);
    result.fold((l) => emit(UploadFileToFireStorageFailureState(l.message)),
            (r){
          fileUrl = r;
          emit(UploadFileToFireStorageSuccessState());
        });
    return fileUrl;
  }

  Future<void> deleteStoredFile({required String fileUrl})async{
    final result = await _deleteStoredFileUseCase.deleteStoredFile(fileUrl: fileUrl);
    result.fold((l) => emit(DeleteStoredFileFailureState(l.message)),
            (r){
          emit(DeleteStoredFileSuccessState());
        });
  }


}
