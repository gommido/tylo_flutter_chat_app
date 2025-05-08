part of 'audio_player_cubit.dart';

@immutable
abstract class AudioPlayerState {}

class AudioPlayerInitial extends AudioPlayerState {}

class InitPlayerControllerState extends AudioPlayerState {}

class InitAudioDataState extends AudioPlayerState {}

class SetCurrentAudioUrlState extends AudioPlayerState {}

class OnSetAudioPathLoadingState extends AudioPlayerState {}
class OnSetAudioPathSuccessState extends AudioPlayerState {}

class OnAudioListenerState extends AudioPlayerState {}

class OnPlayerStateState extends AudioPlayerState {}

class OnDisposeState extends AudioPlayerState {}

class OnPlayState extends AudioPlayerState {}

class OnPauseState extends AudioPlayerState {}

class OnSeekState extends AudioPlayerState {}

class OnStopState extends AudioPlayerState {}
