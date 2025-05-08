String formatTime(int seconds) {
  final int minutes = seconds ~/ 60;
  final int remainingSeconds = seconds % 60;
  final String formattedTime = '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  return formattedTime;
}