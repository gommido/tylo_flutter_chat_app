part of 'video_cubit.dart';

@immutable
abstract class VideoState {}

class VideoInitial extends VideoState {}

class SetCurrentVideoUrlState extends VideoState {}

class InitVideoFileSuccessState extends VideoState {}
class InitVideoFileFailureState extends VideoState {}

class PlayVideoState extends VideoState {}

class PauseVideoState extends VideoState {}

class OnVideoListenerState extends VideoState {}

class OnSeekState extends VideoState {}

class OnSetVolumeState extends VideoState {}

class OnDisposeState extends VideoState {}

