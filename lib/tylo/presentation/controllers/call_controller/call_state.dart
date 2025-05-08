part of 'call_cubit.dart';

@immutable
abstract class CallState {}

class CallInitial extends CallState {}

class SetIsCalledByMeDataState extends CallState {}

class CreateRoomLoadingState extends CallState {}
class CreateRoomSuccessState extends CallState {}
class CreateRoomFailureState extends CallState {
  final String error;
  CreateRoomFailureState(this.error);
}

class CreateCallSuccessState extends CallState {}
class CreateCallFailureState extends CallState {
  final String error;
  CreateCallFailureState(this.error);
}

class GetCallRoomCreatedByMeSuccessState extends CallState {}
class GetCallRoomCreatedByMeFailureState extends CallState {
  final String error;
  GetCallRoomCreatedByMeFailureState(this.error);
}

class GetCallRoomSuccessState extends CallState {}
class GetCallRoomFailureState extends CallState {
  final String error;
  GetCallRoomFailureState(this.error);
}

class GetMyCallsSuccessState extends CallState {}
class GetMyCallsFailureState extends CallState {
  final String error;
  GetMyCallsFailureState(this.error);
}


class UpdateCallReceiverDataSuccessState extends CallState {}
class UpdateCallReceiverDataFailureState extends CallState {
  final String error;
  UpdateCallReceiverDataFailureState(this.error);
}

class DeleteRoomSuccessState extends CallState {}
class DeleteRoomFailureState extends CallState {
  final String error;
  DeleteRoomFailureState(this.error);
}


class PlayCallToneState extends CallState {}


class SetIsCallAnsweredDataState extends CallState {}

class StopCallToneState extends CallState {}

class SetCallRespondDataState extends CallState {}

class SetRoomOutState extends CallState {}

class GetMyRoomsSuccessState extends CallState {}
class GetMyRoomsFailureState extends CallState {
  final String error;
  GetMyRoomsFailureState(this.error);
}

class GetCallDurationState extends CallState {}
class CancelCallDurationTimingState extends CallState {}


class InitOffsetAndSizeData extends CallState {}

class HandlePanUpdateState extends CallState {}

class OnAutoCallCancelLoadingState extends CallState {}
class OnAutoCallCancelSuccessState extends CallState {}

class SetIsRoomJoinedDataState extends CallState {}

class DeleteCallsSuccessState extends CallState {}
class DeleteCallsFailureState extends CallState {
  final String error;
  DeleteCallsFailureState(this.error);
}

class ClearMyCallsListState extends CallState {}
