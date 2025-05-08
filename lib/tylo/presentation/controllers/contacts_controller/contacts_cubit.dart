import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tylo/tylo/core/helper_functions/get_contact_single_number.dart';
import 'package:tylo/tylo/core/resources/constants/firebase_constants.dart';
import 'package:tylo/tylo/core/services/shared_preference/shared_prefs_manager.dart';
import 'package:tylo/tylo/core/utils/permission_manager.dart';
import 'package:tylo/tylo/domain/entities/app_contact.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/local_storage_controller/local_storage_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/helper_functions/check_if_number_contains_country_code.dart';
import '../../../core/resources/constants/app_strings.dart';
import '../../../core/utils/contacts_manager.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit(
      this._fireStoreCubit,
      this._localStorageCubit,
      ) : super(ContactsInitial());
  final FireStoreCubit _fireStoreCubit;
  final LocalStorageCubit _localStorageCubit;

  PermissionManager permissionManager = PermissionManager();

  PermissionStatus? permissionStatus;

  Future<PermissionStatus?> getPermissionStatus({required String id})async{
    permissionStatus = await permissionManager.getPermission(Permission.contacts);
    if(permissionStatus == PermissionStatus.granted){
      await getPhoneContacts(id: id);
    }
    emit(GetPermissionStatusState());
    return permissionStatus;
  }

  late ContactsManager _contactsManager;
  late List<String> _contactsIds;
  List<String> get contactsIds => _contactsIds;

  Future<List<AppContact>> getPhoneContacts({required String id})async{
    emit(GetPhoneContactsLoadingState());
    _contactsManager = ContactsManager();
    List<AppContact> registeredContacts = [];
    List<AppContact> notRegisteredContacts = [];
    List<String> phones = [];
    Map<String, bool> photoVisibility = {};
    _contactsIds = [];
    final result = await _contactsManager.getPhoneContacts();
    result.fold((l) => emit(GetPhoneContactsFailureState(l.message)),
            (allContacts)async{
              for(final phoneContact in allContacts) {
                final contact = getContactSingleNumber(phoneContact);
                final number = checkIfNumberContainsCountryCode(contact);
                //print('${phoneContact.displayName} ==>>> $number');
                final user = await _fireStoreCubit.checkIfUserExistByField(
                  field: FireBaseConstants.phone,
                  value: number,
                );
                if (user != null && user.id != id && !phones.contains(number)) {
                  phones.add(number);
                  AppContact appContact = AppContact(
                      id: user.id,
                      name: phoneContact.displayName,
                      phone: user.phone,
                      image: user.photo,
                    photoVisibility: user.photoVisibility,
                    whoBlockMeList: user.whoBlockMeList,
                  );
                  registeredContacts.add(appContact);
                  _contactsIds.add(user.id);
                  switch(user.photoVisibility){
                    case AppStrings.everyone: photoVisibility[user.id] = true;
                    case AppStrings.nobody: photoVisibility[user.id] = false;
                    case AppStrings.contacts:
                      if(user.contacts.contains(id)){
                        photoVisibility[user.id] = true;
                      }else{
                        photoVisibility[user.id] = false;
                      }
                  }
                } else {
                  AppContact appContact = AppContact(id: phoneContact.id, name: phoneContact.displayName, phone: contact, image: '', photoVisibility: '', whoBlockMeList: [],);
                  notRegisteredContacts.add(appContact);
                }
              }
              await _localStorageCubit.saveRegisteredContactsToLocalStorage( contacts: registeredContacts);
              _localStorageCubit.getRegisteredContactsFromLocalStorage();
              await _localStorageCubit.saveNotRegisteredContactsToLocalStorage( contacts: notRegisteredContacts);
              _localStorageCubit.getNotRegisteredContactsFromLocalStorage();
              await SharedPrefsManager.saveMapData(key: 'photoVisibility', map: photoVisibility);
              SharedPrefsManager.getMapData(key: 'photoVisibility');
              emit(GetPhoneContactsSuccessState());
    });
    return [];
    }

  Future<void> openSettingApp()async{
    await permissionManager.openPhoneSettingApp().then((value){
      emit(OpenSettingAppState());
    });
  }


  Future<Contact> insertNewContact({
    required String name,
    required String phoneNumber,
  })async{
    final newContact = Contact(
      name: Name(first: name),
      phones: [Phone(phoneNumber),],
    );
    final result = await _contactsManager.insertContact(
      contact: newContact,
    );
    result.fold((l) => emit(InsertNewContactFailureState(l.message)),
            (contact){
      emit(InsertNewContactSuccessState());
        });
    return newContact;
  }

  int? _selectedContact;
  int? get selectedContact => _selectedContact;

  void initSelectedContact(){
    _selectedContact = null;
    emit(InitSelectedContactState());
  }

  void selectContactToShare(int index){
    _selectedContact = index;
    emit(SelectContactToShareState());
  }

  void shareApp({required String invitation})async{
    final result = await Share.share(invitation);
    if (result.status == ShareResultStatus.success) {
      emit(SelectContactToShareState());
    }
  }

  void sendSMS({required String phoneNumber, required String invitation})async{
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: <String, String>{
        'body': invitation,
      },
    );

    if (await canLaunchUrl(smsUri)) {
       await launchUrl(smsUri);
       emit(SendSMSMessageState());
    } else {
      throw 'Could not launch SMS app';
    }
  }

  late TextEditingController _nameController;
  TextEditingController get nameController => _nameController;

  late TextEditingController _phoneNumberController;
  TextEditingController get phoneNumberController => _phoneNumberController;

  void initAddContactTextEditingController(){
    _nameController = TextEditingController();
    _phoneNumberController = TextEditingController();
  }

  void disposeAddContactTextEditingController(){
    _nameController.dispose();
    _phoneNumberController.dispose();
  }

}
