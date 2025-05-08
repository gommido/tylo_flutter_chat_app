String capitalizeAllWords(String input) {
  List<String> words = input.split(" ");
  if (words.length > 1) {
    String completeWord = '';
    for(final word in words){
      String currentWord = word[0].toUpperCase() + word.substring(1);
      if(completeWord.isEmpty){
        completeWord = currentWord ;
      } else{
        completeWord = '$completeWord $currentWord' ;
      }
    }
    return completeWord;
  } else {
    return input[0].toUpperCase() + input.substring(1);
  }
}