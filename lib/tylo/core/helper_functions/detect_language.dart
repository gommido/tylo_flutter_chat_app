bool detectWordLanguage(String word) {
  final latinRegExp = RegExp(r'^[A-Za-z]+$');
  if (latinRegExp.hasMatch(word)) {
    return true;
  }
  return false;
}

