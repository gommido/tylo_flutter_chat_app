import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/file_picker_manager/file_picker_manager.dart';

part 'file_picker_state.dart';


class FilePickerCubit extends Cubit<FilePickerState> {
  FilePickerCubit(this._filePickerManager) : super(FilePickerInitial());
  final FilePickerManager _filePickerManager;


  (File?, String?)? _pickedFile;
  (File?, String?)? get pickedFile => _pickedFile;


  Future<(File?, String?)?> pickFile({
    required ImageSource source,
    required String type,
  })async{
    try{
      _pickedFile = await _filePickerManager.pickFile(source: source, type: type);
      emit(PickFileSuccessState());
      return _pickedFile;
    } catch (error){
      emit(PickFileFailureState(error.toString()));
    }
    return null;
  }

  void nullifyPickedFileData(){
    _pickedFile = null;
    emit(NullifyPickedFileDataState());
  }


}
