
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tylo/tylo/core/services/secure_local_storage/secure_local_storage.dart';
import 'package:tylo/tylo/domain/use_cases/firebase_firestore/update_block_contact_status_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/firebase_firestore/delete_firebase_document_use_case.dart';
import '../../../domain/entities/app_user.dart';
import '../../../domain/use_cases/firebase_firestore/check_if_user_exist_by_field_use_case.dart';
import '../../../domain/use_cases/firebase_firestore/create_app_user_use_case.dart';
import '../../../domain/use_cases/firebase_firestore/get_online_users_use_case.dart';
import '../../../domain/use_cases/firebase_firestore/get_user_as_future_use_case.dart';
import '../../../domain/use_cases/firebase_firestore/get_user_as_stream_use_case.dart';
import '../../../domain/use_cases/firebase_firestore/update_app_user_data_usecase.dart';


part 'fire_store_state.dart';

class FireStoreCubit extends Cubit<FireStoreState> {
  FireStoreCubit(
      this._createAppUserUseCase,
      this._updateAppUserDataUseCase,
      this._checkIfUserExistByFieldUseCase,
      this._getUserAsStreamUseCase,
      this._getUserAsFutureUseCase,
      this._deleteFirebaseDocumentUseCase,
      this._getOnlineUsersUseCase,
      this._updateBlockContactStatusUseCase
  ) : super(FireStoreInitial()){
    _profileNameController = TextEditingController();
    _bioController = TextEditingController();
  }

  final CreateAppUserUseCase _createAppUserUseCase;
  final UpdateAppUserDataUseCase _updateAppUserDataUseCase;
  final CheckIfUserExistByFieldUseCase _checkIfUserExistByFieldUseCase;
  final GetUserAsStreamUseCase _getUserAsStreamUseCase;
  final GetUserAsFutureUseCase _getUserAsFutureUseCase;
  final DeleteFirebaseDocumentUseCase _deleteFirebaseDocumentUseCase;
  final UpdateBlockContactStatusUseCase _updateBlockContactStatusUseCase;
  final GetOnlineUsersUseCase _getOnlineUsersUseCase;

  late TextEditingController _profileNameController;
  TextEditingController get profileNameController => _profileNameController;

  // Dispose Profile Name Controller
  void disposeProfileNameController(){
    _profileNameController.dispose();
  }

  late TextEditingController _bioController;
  TextEditingController get bioController => _bioController;

  // Dispose Bio Controller
  void disposeBioController(){
    _bioController.dispose();
  }

  late String _profileName;
  get profileName => _profileName;

  // Set User Profile Name
  void setProfileName(String profileName) {
    _profileName = profileName;
    emit(SetProfileNameState());
  }

  // Create Firebase App User
  Future<void> createAppUser({required String phoneNumber,})async{
    emit(CreateAppUserLoadingState());
    String? number;
    number = phoneNumber.replaceAll('+', '00');
    final id = await SecureLocalStorage.read(key: 'id');
    final result = await _createAppUserUseCase.createAppUser(
      id:  id!,
      name: _profileName,
      phone: number,
      photo:'',
      token: '',
    );
    result.fold((l) => emit(CreateAppUserFailureState(l.message)),
          (r){
        emit(CreateAppUserDelayState());
        Future.delayed(const Duration(seconds: 3), (){
          emit(CreateAppUserSuccessState());
        });
      },
    );
  }

  /*
   // Create Firebase App User
  Future<void> createAppUser({
    String? phoneNumber,
    required AuthCubit fireBaseAuthCubit,
  })async{
    emit(CreateAppUserLoadingState());
    //await createAppUserInDatabase(id: SharedPrefsManager.getStringData(key: 'id')!);
    String? number;
    if(phoneNumber != null){
      number = phoneNumber.replaceAll('+', '00');
    }
    final token = await FireBaseNotification.getDeviceToken();
    await SharedPrefsManager.saveStringData(key: 'token', value: token ?? '');
    final result = await _createAppUserUseCase.createAppUser(
      id:  phoneNumber != null ? SharedPrefsManager.getStringData(key: 'id')! : fireBaseAuthCubit.user!.uid,
      name: phoneNumber != null ? _profileName : fireBaseAuthCubit.user!.displayName!,
      phone: number,
      email: phoneNumber != null ? null : fireBaseAuthCubit.user!.email!,
      image: phoneNumber != null ? null : fireBaseAuthCubit.user!.photoURL!,
      token: token ?? '',
    );
    result.fold((l) => emit(CreateAppUserFailureState(l.message)),
          (r){
        emit(CreateAppUserDelayState());
        Future.delayed(const Duration(seconds: 3), (){
          emit(CreateAppUserSuccessState());
        });
      },
    );
  }
   */



  // Create firebase app user with phone number
  Future<void> createUserWithPhoneNumber({
    required String phoneNumber,
    Future<String>? onUploadProfileImage,
  })async{
    await createAppUser(phoneNumber: phoneNumber,);
    if (onUploadProfileImage != null) {
      final fileUrl = await onUploadProfileImage;
      final id = await SecureLocalStorage.read(key: 'id');
      await updateAppUserData(
        id: id!,
        field: 'photo',
        value: fileUrl,
      );
    }
  }

  // Update firebase app user data
  Future<void> updateAppUserData({
    required String id,
    required String field,
    dynamic value,
  })async{
    emit(UpdateAppUserDataLoadingState());
    final result = await _updateAppUserDataUseCase.updateAppUserData(
      id: id,
      field: field,
      value: value,
    );
    result.fold((l) => emit(UpdateAppUserDataFailureState(l.message)),
            (r)async{
              emit(UpdateAppUserDataSuccessState());
            },
    );
  }

  AppUser? _currentAppUser;
  AppUser? get currentAppUser => _currentAppUser;
  AppUser? getCurrentUserAsStream({required String id}) {
    try{
      _getUserAsStreamUseCase.getUserAsStream(id: id).listen((event) {
        _currentAppUser = event;
        emit(GetCurrentUserDataSuccessState());
      });
    } on Exception catch(error){
      emit(GetCurrentUserDataFailureState(error.toString()));
    }
    return _currentAppUser;
  }

  AppUser? _streamAppUser;
  AppUser? get streamAppUser => _streamAppUser;
  AppUser? getUserAsStream({required String id}){
    try{
      _getUserAsStreamUseCase.getUserAsStream(id: id,).listen((event) {
        _streamAppUser = event;
        emit(GetUserDataSuccessState());
      });
    } on Exception catch(error){
      emit(GetUserDataFailureState(error.toString()));
    }
    return _streamAppUser;
  }

  AppUser? _futureAppUser;
  AppUser? get futureAppUser => _futureAppUser;
  Future<AppUser?> getUserAsFuture({required String id,}) async {
    final result = await _getUserAsFutureUseCase.getUserAsFuture(id: id,);
    result.fold((l) => emit(GetUserDataFailureState(l.message)),
            (r) {
              _futureAppUser = r;
          emit(GetUserDataSuccessState());
        });
    return _futureAppUser;
  }

  AppUser? _existUser;
  AppUser? get existUser => _existUser;
  Future<AppUser?> checkIfUserExistByField({required String field, required String value,}) async {
    emit(CheckIfUserExistByFieldLoadingState());
    final result = await _checkIfUserExistByFieldUseCase.checkIfUserExistByField(field: field, value: value);
    result.fold((l) => emit(CheckIfUserExistByFieldFailureState(l.message)),
            (r) {
              _existUser = r;
              emit(CheckIfUserExistByFieldSuccessState());

            });
    return _existUser;
  }

  bool? _isUserNameTaken;
  bool? get isUserNameTaken => _isUserNameTaken;
  void checkUserNameTaken(){
    _isUserNameTaken = true;
    emit(CheckUserNameTakenState());
  }

  bool? _isNameWarningShown;
  bool? get isNameWarningShown => _isNameWarningShown;
  void setNameWarningShown(){
    if(_isNameWarningShown == null){
      _isNameWarningShown = true;
    }else{
      _isNameWarningShown = null;
    }
    emit(SetNameWarningShownState());
  }

  bool? _isEditName;
  bool? get isEditName => _isEditName;
  void setIsEditName(){
    _isEditName = true;
    emit(SetIsAppUserDataState());
  }

  String? _editProfileBottomSheetName;
  String? get editProfileBottomSheetName => _editProfileBottomSheetName;
  void setEditProfileBottomSheetName(String name){
    _editProfileBottomSheetName = name;
    emit(SetIsAppUserDataState());
  }

  bool? _isProfileImageUploading;
  bool? get isProfileImageUploading => _isProfileImageUploading;
  void setProfileImageUploadingState(){
    if(_isProfileImageUploading == null){
      _isProfileImageUploading = true;
    }else{
      _isProfileImageUploading = null;
    }
    emit(SetProfileImageUploadingState());
  }


  bool? _isEditUserName;
  bool? get isEditUserName => _isEditUserName;
  void setIsEditUserName(){
    _isEditUserName = true;
    emit(SetIsAppUserDataState());
  }


  bool? _isEditBio;
  bool? get isEditBio => _isEditBio;
  void setIsEditBio(){
    _isEditBio = true;
    emit(SetIsAppUserDataState());
  }


  // Delete Firebase Doc
  Future<void> deleteFirebaseDocument({
    required String collectionPath,
    required String id,
  }) async{
    final result = await _deleteFirebaseDocumentUseCase.deleteFirebaseDocument(collectionPath: collectionPath, id: id);
    result.fold((l) => emit(DeleteFirebaseDocumentFailureState(l.message)),
            (r) async {
          emit(DeleteFirebaseDocumentSuccessState());
        });
  }

  // block Contact
  Future<void> blockContact({
    required String blockedId,
    required bool isBlocking,
  }) async {
    final id = await SecureLocalStorage.read(key: 'id');
    final result = await _updateBlockContactStatusUseCase.updateBlockContactStatus(
      blockedId: blockedId,
      id: id!,
      isBlocking: isBlocking,
    );
    result.fold(
          (l) => emit(BlockContactFailureState(l.message)),
          (r) => emit(BlockContactSuccessState()),);
  }


  // Get Online Users
  late List<AppUser> _onlineUsers;
  List<AppUser> get onlineUsers => _onlineUsers;
  List<AppUser> getOnlineUsers({required List<String> ids}) {
    try {
      _onlineUsers = [];
      _getOnlineUsersUseCase.getOnlineUsers(ids: ids,).listen((onlineUsers) {
  _onlineUsers = onlineUsers;
        emit(GetOnlineUsersSuccessState());
      });
    } on FirebaseException catch (error) {
      emit(GetOnlineUsersFailureState(error.message.toString()));
    }
    return _onlineUsers;
  }

}
