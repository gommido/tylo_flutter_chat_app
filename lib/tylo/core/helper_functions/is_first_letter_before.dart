bool isFirstLetterBefore(String string1, String string2) {
  String firstLetter1 = string1[0].toLowerCase();
  String firstLetter2 = string2[0].toLowerCase();

  return firstLetter1.compareTo(firstLetter2) < 0;
}

