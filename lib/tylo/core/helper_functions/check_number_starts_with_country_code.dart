
String checkIfNumberStartWithCountryCode(String number){
  String phoneNumber;
  if (!number.startsWith('00')) {
    phoneNumber = '002$number';
  } else {
    phoneNumber = number;
  }
  return phoneNumber;
}