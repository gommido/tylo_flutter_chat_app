
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileInitial());

  late bool _isVisible;
  bool get isVisible => _isVisible;

  void initVisibility(){
    _isVisible = false;
    emit(InitVisibilityState());
  }

  void setVisibility(){
    _isVisible = !_isVisible;
    emit(SetVisibilityState());
  }

  late TextEditingController _userNameController;
  TextEditingController get userNameController => _userNameController;

  void initNameController(){
    _userNameController = TextEditingController();
    emit(InitUserNameControllerState());
  }

  void disposeNameController(){
    _userNameController.dispose();
    emit(DisposeUserNameControllerState());
  }


}
