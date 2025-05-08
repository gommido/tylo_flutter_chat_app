
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'agora_call_state.dart';

class AgoraCallCubit extends Cubit<AgoraCallState> {
  AgoraCallCubit() : super(AgoraCallInitial());

  AgoraClient? _client;
  AgoraClient? get client => _client;

  Future<void> initAgoraClient() async{
    emit(InitAgoraClientLoadingState());
    try{
      _client = AgoraClient(
        agoraConnectionData: AgoraConnectionData(
          appId: "",
          channelName: "test",
          username: '',
        ),
      );

      emit(InitAgoraClientSuccessState());
    } on Exception catch(error){
      emit(InitAgoraClientFailureState(error.toString()));

    }
  }

  Future<void> initializeAgora() async{
    await _client!.initialize();
    emit(InitializeAgoraState());
  }

  Future<void> releaseAgora() async{
    await _client!.release();
    emit(ReleaseAgoraState());
  }

  void nullifyClient(){
    _client = null;
    emit(ReleaseAgoraState());
  }
}
