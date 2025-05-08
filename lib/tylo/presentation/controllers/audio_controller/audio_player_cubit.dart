
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';

part 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  AudioPlayerCubit() : super(AudioPlayerInitial());

  late AudioPlayer _player;
  AudioPlayer get player => _player;

  late int _duration;
  int get duration => _duration;

  late int _position;
  int get position => _position;

  String? _currentAudioUrl;
  String? get currentAudioUrl => _currentAudioUrl;
  int? _currentDuration;

  void setCurrentAudioUrl({required String audioUrl, required int duration}){
    _currentAudioUrl = audioUrl;
    _currentDuration = duration;
    emit(SetCurrentAudioUrlState());
  }

  Future<void> initPlayerController()async {
    _player = AudioPlayer();
    emit(InitPlayerControllerState());
  }

  void initAudioData(){
    _position = 0;
    _duration = 0;
    _currentAudioUrl = null;
    _currentDuration= null;
    emit(InitAudioDataState());
  }

  Future<void> onSetAudioFile({required String assetPath,}) async {
    await _player.setFilePath(assetPath);
    if(_player.duration != null){
      _duration = _player.duration!.inSeconds;
    }
    onAudioListener(duration: _duration);
    emit(OnSetAudioPathSuccessState());
  }


  Future<void> onSetAudioUrl({required int duration,})async {
    emit(OnSetAudioPathLoadingState());

    await _player.setUrl(_currentAudioUrl!);
    onAudioListener(duration: _currentDuration);
     onPlay();
    emit(OnSetAudioPathSuccessState());
  }

  void playOngoingCallSound() async{
    await _player.setAsset('assets/audio/ongoing_call_sound.mp3');
    await _player.setLoopMode(LoopMode.all);
    onPlay();
    emit(OnSetAudioPathSuccessState());
  }

  void playIncomingCallSound() async{
    await _player.setAsset('assets/audio/outgoing_call_sound.mp3');
    await _player.setLoopMode(LoopMode.all);
    onPlay();
    emit(OnSetAudioPathSuccessState());
  }


  void onPlay() {
    _player.play();
    emit(OnPlayState());
  }

  Future<void> onPause()async {
    await _player.pause();
    emit(OnPauseState());
  }

  Future<void> onStop()async {
    await _player.stop();
    emit(OnStopState());
  }

  Future<void> onSeek({double? position})async {
    if(position == null){
      await _player.seek(Duration.zero);
    }else{
      await _player.seek(Duration(seconds: position.toInt()));
    }
    emit(OnSeekState());
  }

  void onAudioListener({int? duration}){
    _player.positionStream.listen((event) {
      _position = event.inSeconds;
      if(duration != null){
        if(_position == duration ||
            ((duration - _position <= 1) && !_player.playing)){
          onPause().then((value){
            onSeek();
          });
          emit(OnAudioListenerState());
        }
      }
      emit(OnAudioListenerState());
    });
  }

  void onDispose() {
    _player.dispose();
    emit(OnDisposeState());
  }


}
