import '../network/error_message.dart';

class FireBaseExceptions implements Exception{
  final ErrorMessage errorMessage;
  FireBaseExceptions({
    required this.errorMessage
});

}

class LocalExceptions implements Exception{
  final ErrorMessage errorMessage;
  LocalExceptions({
    required this.errorMessage
  });

}