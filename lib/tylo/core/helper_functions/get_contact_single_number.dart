
import 'package:flutter_contacts/contact.dart';

String getContactSingleNumber(Contact contact){
  String phoneNumber = '';
  contact.phones.toSet().forEach((element) {
    if(element.number.length >= 10){
      phoneNumber =  element.number.replaceAll(' ', '');
    }
  });
  return phoneNumber;
}
