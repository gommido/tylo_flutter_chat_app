part of 'contacts_cubit.dart';

@immutable
abstract class ContactsState {}

class ContactsInitial extends ContactsState {}

class GetPhoneContactsLoadingState extends ContactsState {}
class GetPhoneContactsSuccessState extends ContactsState {}
class GetPhoneContactsFailureState extends ContactsState {
  final String error;
  GetPhoneContactsFailureState(this.error);
}

class InsertNewContactSuccessState extends ContactsState {}
class InsertNewContactFailureState extends ContactsState {
  final String error;
  InsertNewContactFailureState(this.error);
}

class GetPermissionStatusState extends ContactsState {}

class OpenSettingAppState extends ContactsState {}

class InitSelectedContactState extends ContactsState {}

class SelectContactToShareState extends ContactsState {}

class SendSMSMessageState extends ContactsState {}
