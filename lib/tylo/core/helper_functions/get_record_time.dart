int convertDurationToSeconds(String duration){
  List<String> parts = duration.split(':');
  int minutes = int.parse(parts[0]);
  int seconds = int.parse(parts[1]);
  int totalSeconds = minutes * 60 + seconds;
  return totalSeconds;
}

String convertSecondsToDuration(int totalSeconds) {
  Duration duration = Duration(seconds: totalSeconds);
  int minutes = duration.inMinutes;
  int seconds = duration.inSeconds % 60;
  String minutesStr = minutes.toString().padLeft(2, '0');
  String secondsStr = seconds.toString().padLeft(2, '0');
  return "$minutesStr:$secondsStr";
}
