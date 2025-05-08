part of 'agora_call_cubit.dart';

@immutable
abstract class AgoraCallState {}

class AgoraCallInitial extends AgoraCallState {}

class InitAgoraClientLoadingState extends AgoraCallState {}
class InitAgoraClientSuccessState extends AgoraCallState {}
class InitAgoraClientFailureState extends AgoraCallState {
  final String error;
  InitAgoraClientFailureState(this.error);
}

class InitializeAgoraState extends AgoraCallState {}

class ReleaseAgoraState extends AgoraCallState {}
