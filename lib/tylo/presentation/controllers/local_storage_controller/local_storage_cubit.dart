import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/domain/use_cases/local_storage/save_contacts_to_local_storage_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/local_storage/get_contacts_from_local_storage_use_case.dart';
import '../../../domain/entities/app_contact.dart';
part 'local_storage_state.dart';

class LocalStorageCubit extends Cubit<LocalStorageState> {
  LocalStorageCubit(
      this._saveContactsToLocalStorageUseCase,
      this._getContactsFromLocalStorageUseCase,
      ) : super(LocalStorageInitial()){
    _storedRegisteredContacts = [];
    _storedNotRegisteredContacts = [];
  }
  final SaveContactsToLocalStorageUseCase _saveContactsToLocalStorageUseCase;
  final GetContactsFromLocalStorageUseCase _getContactsFromLocalStorageUseCase;


  Future<bool> saveRegisteredContactsToLocalStorage({
    required List<AppContact> contacts
  }) async{
    final result = await _saveContactsToLocalStorageUseCase.saveContactsToLocalStorage(key: 'registered', contacts: contacts);
    result.fold(
          (l) => emit(GetContactsFromLocalStorageFailureState(l.message)),
          (r) => emit(SaveContactsToLocalStorageSuccessState()),
    );
    return false;
  }

  late List<AppContact> _storedRegisteredContacts;
  List<AppContact> get storedRegisteredContacts => _storedRegisteredContacts;

  List<AppContact>  getRegisteredContactsFromLocalStorage(){
    final result = _getContactsFromLocalStorageUseCase.getContactsFromLocalStorage(key: 'registered');
    result.fold(
          (l) => emit(GetContactsFromLocalStorageFailureState(l.message)),
          (r){
            _storedRegisteredContacts = r;
            emit(SaveContactsToLocalStorageSuccessState());
          },
    );
    return _storedRegisteredContacts;
  }

  Future<bool> saveNotRegisteredContactsToLocalStorage({
    required List<AppContact> contacts
  }) async{
    final result = await _saveContactsToLocalStorageUseCase.saveContactsToLocalStorage(key: 'notRegistered', contacts: contacts);
    result.fold(
          (l) => emit(GetContactsFromLocalStorageFailureState(l.message)),
          (r) => emit(SaveContactsToLocalStorageSuccessState()),
    );
    return false;
  }

  late List<AppContact> _storedNotRegisteredContacts;
  List<AppContact> get storedNotRegisteredContacts => _storedNotRegisteredContacts;

  List<AppContact>  getNotRegisteredContactsFromLocalStorage(){
    final result = _getContactsFromLocalStorageUseCase.getContactsFromLocalStorage(key: 'notRegistered');
    result.fold(
          (l) => emit(GetContactsFromLocalStorageFailureState(l.message)),
          (r){
            _storedNotRegisteredContacts = r;
        emit(SaveContactsToLocalStorageSuccessState());
      },
    );
    return _storedNotRegisteredContacts;
  }

  Future<bool> saveBlockedContactsToLocalStorage({
    required List<AppContact> contacts
  }) async{
    final result = await _saveContactsToLocalStorageUseCase.saveContactsToLocalStorage(key: 'blockedContacts', contacts: contacts);
    result.fold(
          (l) => emit(GetContactsFromLocalStorageFailureState(l.message)),
          (r) => emit(SaveContactsToLocalStorageSuccessState()),
    );
    return false;
  }

  List<AppContact>  getBlockedContactsFromLocalStorage(){
    late List<AppContact> blockedContacts = [];
    final result = _getContactsFromLocalStorageUseCase.getContactsFromLocalStorage(key: 'blockedContacts');
    result.fold(
          (l) => emit(GetContactsFromLocalStorageFailureState(l.message)),
          (r){
            blockedContacts = r;

        emit(SaveContactsToLocalStorageSuccessState());
      },
    );
    return blockedContacts;
  }

  String getStoredContactName({required String id, }){
    String name = '';
    final names = _storedRegisteredContacts.where((contact) => contact.id == id).toList();
    if(names.isNotEmpty){
     name = names.first.name;
    }
    emit(GetStoredContactNameState());
    return name;
  }

  List<AppContact> searchForContacts(String searchedCharacter) {
    final users =  _storedRegisteredContacts.where((contact) => contact.name.toLowerCase().startsWith(searchedCharacter)).toList();
    emit(SearchForContactsState());
    return users;
  }

}
