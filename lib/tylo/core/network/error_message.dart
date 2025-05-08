
class ErrorMessage{
  final String message;
  const ErrorMessage({
    required this.message,
});


  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    return ErrorMessage(
      message: json["message"],
    );
  }

}