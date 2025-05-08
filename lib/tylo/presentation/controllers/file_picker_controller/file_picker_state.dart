part of 'file_picker_cubit.dart';

@immutable
abstract class FilePickerState {}

class FilePickerInitial extends FilePickerState {}

class PickFileSuccessState extends FilePickerState {}
class PickFileFailureState extends FilePickerState {
  final String error;
  PickFileFailureState(this.error);
}

class NullifyPickedFileDataState extends FilePickerState {}
