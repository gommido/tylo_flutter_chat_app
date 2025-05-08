import 'dart:math';

late Random random;
String getUuid(){
  final random = Random();
  // Generate the first digit (ensure it's non-zero)
  String firstDigit = (random.nextInt(9) + 1).toString();
  // Generate the remaining 19 digits
  String otherDigits = List.generate(24, (_) => random.nextInt(10).toString()).join();
  // Combine them to form a 20-digit number
  String randomNumber = firstDigit + otherDigits;
  print(randomNumber);
  return randomNumber;
  //return const Uuid().v4();
}