String formatAudioDuration(int seconds,) {
  final minutes = (seconds / 60).floor();
  final remainingSeconds = seconds % 60;

  final twoDigitMinutes = minutes.toString().padLeft(2, '0');
  final twoDigitSeconds = remainingSeconds.toString().padLeft(2, '0');

  return '$twoDigitMinutes:$twoDigitSeconds';
}