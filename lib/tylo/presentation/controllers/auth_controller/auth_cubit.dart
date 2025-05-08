import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/services/secure_local_storage/secure_local_storage.dart';
import '../../../domain/use_cases/firebase_auth/get_current_user_id_use_case.dart';
import '../../../domain/use_cases/firebase_auth/sign_up_with_phone_number_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
      this._signUpWithPhoneNumberUseCase,
      this._getCurrentUserIdUseCase,
      ) : super(AuthInitial()){
    _phoneController = TextEditingController();
    _codeController = TextEditingController();
    _focusNode = FocusNode();
  }

  final SignUpWithPhoneNumberUseCase _signUpWithPhoneNumberUseCase;
  final GetCurrentUserIdUseCase _getCurrentUserIdUseCase;

  late TextEditingController _phoneController;
  TextEditingController get phoneController => _phoneController;

  late TextEditingController _codeController;
  TextEditingController get codeController => _codeController;

  late FocusNode _focusNode;
  FocusNode get focusNode => _focusNode;

  late String _phoneNumber;
  String get phoneNumber => _phoneNumber;

  // Dispose Controllers
  void disposeControllers(){
    _phoneController.dispose();
    _codeController.dispose();
    _focusNode.dispose();
  }

  // UnFocus FocusNode
  void unFocus(){
    _focusNode.unfocus();
  }

  // Get User Phone Number
  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
  }

  // Get Current App User Id
  String? getCurrentUserId(){
    String? currentUserId;
    final result = _getCurrentUserIdUseCase.getCurrentUserId();
    result.fold((l) => emit(GetCurrentUserIdFailureState()),
            (r){
              currentUserId = r;
              if(currentUserId != null){
                SecureLocalStorage.write(key: 'id', value: currentUserId!).then((onValue){});
              }
          emit(GetCurrentUserIdSuccessState());
        });
    return currentUserId;
  }

  // Sign Up With Phone Number
  Future<void> signUpWithPhoneNumber()async{
    emit(SignUpWithPhoneNumberLoadingState());
    final result = await _signUpWithPhoneNumberUseCase.signUpWithPhoneNumber(phoneNumber: _phoneNumber);
    result.fold((l)=> emit(SignUpWithPhoneNumberFailureState(l.message)),
            (r){
              emit(SignUpWithPhoneNumberSuccessState());
            },
    );
  }

  // Verify Phone Number
  bool? _isFirstTimePinCode;
  bool? get isFirstTimePinCode => _isFirstTimePinCode;

  Future<void> verifyPhoneNumber()async{
    emit(VerifyPhoneNumberLoadingState());
    final result = await _signUpWithPhoneNumberUseCase.verifyPhoneNumber(smsCode: _pinCode!);
    result.fold((l){
      emit(VerifyPhoneNumberFailureState(l.message));
    },
            (r){
              emit(VerifyPhoneNumberSuccessState());
            }
    );
  }

  // Receiving Pin Code Timing
  Timer? _timer;
  int _timing = 60;
  int get timing => _timing;
  void startPinCodeTimer() {
    emit(ReceivingOTPTimingState());
    _timing = 60;
    const oneSec = Duration(seconds: 1);
    if(_timer != null && _timer!.isActive){
      _timer!.cancel();
    }
    _timer = Timer.periodic(
      oneSec, (Timer timer) {
      if (_timing == 0) {
        timer.cancel();
      } else {
        _timing--;
      }
      emit(ReceivingOTPTimingState());
    },
    );
  }

  // Dispose Pin Code Timing
  void disposeTimer() {
    _timer!.cancel();
  }

  // Set pin Code Controller
  String? _pinCode;
  String? get pinCode => _pinCode;

  void setPinCode(String pin){
    _pinCode = pin;
  }

}

/*

  // Sign In With Google Account
  User? _user;
  User? get user => _user;
  Future<void> signInWithGoogleAccount()async{
    emit(SignInWithAccountLoadingState());
    final result = await _signInWithGoogleAccountUseCase.signInWithGoogleAccount();
    result.fold((l) => emit(SignInWithAccountFailureState(l.message)),
            (user){
          _user = user;
          print(SignInWithAccountSuccessState);
          emit(SignInWithAccountSuccessState());
        });
  }

  // Sign In With Facebook Account
  Future<void> signInWithFacebookAccount()async{
    emit(SignInWithAccountLoadingState());
    final result = await _signInWithFacebookAccountUseCase.signInWithFacebookAccount();
    result.fold((l) => emit(SignInWithAccountFailureState(l.message)),
            (user){
          _user = user;
          emit(SignInWithAccountSuccessState());
        });
  }

 */