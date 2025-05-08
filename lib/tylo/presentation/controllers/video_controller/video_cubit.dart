import 'dart:io';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(VideoInitial());

  CachedVideoPlayerPlusController? _videoFileController;
  CachedVideoPlayerPlusController? get videoFileController => _videoFileController;

  CachedVideoPlayerPlusController? _videoUrlController;
  CachedVideoPlayerPlusController? get videoUrlController => _videoUrlController;

  int currentVideoIndex = 0;
  String currentVideoUrl = '';

  void setCurrentVideo({required int currentIndex, required String currentUrl}){
    currentVideoIndex = currentIndex;
    currentVideoUrl = currentUrl;
    emit(SetCurrentVideoUrlState());
  }

  Future<void> initVideoFile({required File file,})async{
    try{
      _isPlaying = false;
      _videoFileController = CachedVideoPlayerPlusController.file(file);
      await _videoFileController!.initialize();
      onVideoFileListener();
      emit(InitVideoFileSuccessState());
    }catch (error){
      emit(InitVideoFileFailureState());
    }
  }

  Future<void> initInternetVideoUrl({required String path})async{
    try{
      _videoUrlController = CachedVideoPlayerPlusController.networkUrl(Uri.parse(path));
      await _videoUrlController!.initialize();
      await play(fileType: 'url');
      onInternetVideoUrlListener();
      emit(InitVideoFileSuccessState());
    }catch (error){
      emit(InitVideoFileFailureState());
    }
  }

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  late int _duration;
  int get duration => _duration;

  late int _position;
  int get position => _position;

  Future<void> play({required String fileType})async{
    if(fileType == 'file'){
      await _videoFileController!.play();
    }else{
      await _videoUrlController!.play();
    }
    emit(PlayVideoState());
  }

  Future<void> onPause({required String fileType})async{
    if(fileType == 'file'){
      await _videoFileController!.pause();
    }else{
      await _videoUrlController!.pause();
    }
    emit(PauseVideoState());
  }

  double progress = 0;


  void onVideoFileListener(){
    _videoFileController!.addListener((){
      _isPlaying = _videoFileController!.value.isPlaying;
      _duration = _videoFileController!.value.duration.inSeconds;
      _position = _videoFileController!.value.position.inSeconds;
      progress = (_position / _duration);

      if(_position == _duration){
        onSeek(fileType: 'file').then((value){
          onPause(fileType: 'file').then((value){});
        });
        // _isPlaying = null;
      }
      emit(OnVideoListenerState());
    });
  }

  void onInternetVideoUrlListener(){
    _videoUrlController!.addListener((){
      _isPlaying = _videoUrlController!.value.isPlaying;
      _duration = _videoUrlController!.value.duration.inSeconds;
      _position = _videoUrlController!.value.position.inSeconds;
      progress = _position / _duration;

      if(_position == _duration){
        onSeek(fileType: 'url').then((value){
          onPause(fileType: 'url').then((value){
          });
        });
      }
      emit(OnVideoListenerState());
    });
  }

  Future<void> onSeek({required String fileType})async{
    if(fileType == 'file'){
      await _videoFileController!.seekTo(Duration.zero);
    }else{
      await _videoUrlController!.seekTo(Duration.zero);
    }
    emit(OnSeekState());
  }

  Future<void> onVideoFileControllerDispose()async{
    if(_videoFileController != null){
      await _videoFileController!.dispose();
      emit(OnDisposeState());
    }
  }

  Future<void> onVideoUrlControllerDispose()async{
    if(_videoUrlController != null){
      await _videoUrlController!.dispose();
      _videoFileController = null;
      _videoUrlController = null;
      _isPlaying = false;
    }
    emit(OnDisposeState());
  }
  bool? _isMute;
  bool? get isMute => _isMute;

  Future<void> onSetVolume()async{
    if(_isMute == null){
      await _videoUrlController!.setVolume(0.0);
      _isMute = true;
    }else{
      await _videoUrlController!.setVolume(1.0);
      _isMute = null;
    }
    emit(OnSetVolumeState());
  }

  bool? _isLoop;
  bool? get isLoop => _isLoop;

  Future<void> onSetLoop()async{
    if(_isLoop == null){
      await _videoUrlController!.setLooping(true);
      _isLoop = true;
    }else{
      await _videoUrlController!.setLooping(false);
      _isLoop = null;
    }
    emit(OnSetVolumeState());
  }




}
