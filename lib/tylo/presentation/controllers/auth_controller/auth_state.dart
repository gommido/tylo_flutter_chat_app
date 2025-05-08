part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class SetIsPhoneSignUpState extends AuthState{}

class InitPinCodeControllerState extends AuthState{}

class DisposePinCodeeControllerState extends AuthState{}

class GetCurrentUserIdSuccessState extends AuthState{}
class GetCurrentUserIdFailureState extends AuthState{}

class SignUpWithPhoneNumberLoadingState extends AuthState{}
class SignUpWithPhoneNumberSuccessState extends AuthState{}
class SignUpWithPhoneNumberFailureState extends AuthState{
  final String error;
  SignUpWithPhoneNumberFailureState(this.error);
}

class VerifyPhoneNumberLoadingState extends AuthState{}

class VerifyPhoneNumberSuccessState extends AuthState{}

class VerifyPhoneNumberFailureState extends AuthState{
  final String error;
  VerifyPhoneNumberFailureState(this.error);
}

class SignInWithAccountLoadingState extends AuthState{}
class SignInWithAccountSuccessState extends AuthState{}
class SignInWithAccountFailureState extends AuthState{
  final String error;
  SignInWithAccountFailureState(this.error);
}

class ReceivingOTPTimingState extends AuthState {}

