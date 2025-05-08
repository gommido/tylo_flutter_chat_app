part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class SetOtherChatUserIdState extends ChatState {}

class SetChatRoomIdState extends ChatState {}

class ClearChatMessageTextState extends ChatState {}

class ScrollToBottomState extends ChatState {}

class CheckIfUserIsInBottomState extends ChatState {}

class DisposeScrollControllerState extends ChatState {}

class ToggleEmojiState extends ChatState {}

class JumpToLastMessageState extends ChatState {}

class ClearMessageTextState extends ChatState {}

class UnFocusBottomState extends ChatState {}

class UnFocusEmojiFocusNodeState extends ChatState {}

class UnFocusEmojiState extends ChatState {}

class DisposeTextControllerState extends ChatState {}

class PressLongTimeState extends ChatState {}

class GetVideoMessageThumbnailState extends ChatState {}

class SetSendImageIconTappedState extends ChatState {}

class SelectMessageState extends ChatState {}

class SendMessageSuccessState extends ChatState {}
class SendMessageFailureState extends ChatState {
  final String error;
  SendMessageFailureState(this.error);
}

class GetChatMessagesSuccessState extends ChatState {}
class GetChatMessagesFailureState extends ChatState {
  final String error;
  GetChatMessagesFailureState(this.error);
}

class GetUnSeenMessagesCountSuccessState extends ChatState {}
class GetUnSeenMessagesCountFailureState extends ChatState {
  final String error;
  GetUnSeenMessagesCountFailureState(this.error);
}

class GetUnSeenNewChatsCountSuccessState extends ChatState {}
class GetUnSeenNewChatsCountFailureState extends ChatState {
  final String error;
  GetUnSeenNewChatsCountFailureState(this.error);
}

class GetMyChatsLastMessagesSuccessState extends ChatState {}
class GetMyChatsLastMessagesFailureState extends ChatState {
  final String error;
  GetMyChatsLastMessagesFailureState(this.error);
}

class GetChatLastMessageSuccessState extends ChatState {}
class GetChatLastMessageFailureState extends ChatState {
  final String error;
  GetChatLastMessageFailureState(this.error);
}

class UpdateUnSeenMessageSuccessState extends ChatState {}
class UpdateUnSeenMessageFailureState extends ChatState {
  final String error;
  UpdateUnSeenMessageFailureState(this.error);
}

class UpdateUnSeenLastMessageSuccessState extends ChatState {}
class UpdateUnSeenLastMessageFailureState extends ChatState {
  final String error;
  UpdateUnSeenLastMessageFailureState(this.error);
}


class UpdateMessageSuccessState extends ChatState {}
class UpdateMessageFailureState extends ChatState {
  final String error;
  UpdateMessageFailureState(this.error);
}

class SearchNamesLoadingState extends ChatState {}
class SearchNamesSuccessState extends ChatState {}
class SearchNamesFailureState extends ChatState {
  final String error;
  SearchNamesFailureState(this.error);
}

class SendAndUpdateFileMessageSuccessState extends ChatState {}
class SendAndUpdateFileMessageFailureState extends ChatState {
  final String error;
  SendAndUpdateFileMessageFailureState(this.error);
}

class GetMessageTypeState extends ChatState {}

class StartRecordingState extends ChatState {}
class StoptRecordingState extends ChatState {}

class SendVoiceNoteMessageSuccessState extends ChatState {}
class SendVoiceNoteMessageFailureState extends ChatState {
  final String error;
  SendVoiceNoteMessageFailureState(this.error);
}

class SetLastMessageDeleteState extends ChatState {}

class DeleteMessageSuccessState extends ChatState {}
class DeleteFailureStateMessage extends ChatState {
  final String error;
  DeleteFailureStateMessage(this.error);
}

class UpdateTypingStatusSuccessState extends ChatState {}
class UpdateTypingStatusFailureState extends ChatState {
  final String error;
  UpdateTypingStatusFailureState(this.error);
}

class UpdateLastMessageTypingStatusSuccessState extends ChatState {}
class UpdateLastMessageTypingStatusFailureState extends ChatState {
  final String error;
  UpdateLastMessageTypingStatusFailureState(this.error);
}

class ShowDragDownGifState extends ChatState {}

class InitAnimationControllerState extends ChatState {}
class DisposeAnimationControllerState extends ChatState {}

class OnDragUpdateState extends ChatState {}

class OnDragEndState extends ChatState {}

class OnDragUpState extends ChatState {}

class SetVideoPlayerScreenFitState extends ChatState {}

class SetImageMessageScreenFitState extends ChatState {}

class SetCurrentImageMessageIndexState extends ChatState {}

class SetVoiceIconVisibilityState extends ChatState {}

class InitTogglingSeenMessageState extends ChatState {}

class FlipIconState extends ChatState {}

class DisposeAnimationState extends ChatState {}


class DeleteChatLoadingState extends ChatState {}
class DeleteChatSuccessState extends ChatState {}
class DeleteChatFailureState extends ChatState {
  final String error;
  DeleteChatFailureState(this.error);
}

class DeleteChatLastMessageLoadingState extends ChatState {}
class DeleteChatLastMessageSuccessState extends ChatState {}
class DeleteChatLastMessageFailureState extends ChatState {
  final String error;
  DeleteChatLastMessageFailureState(this.error);
}

class DownloadAndSaveImageMessageLoadingState extends ChatState {}
class DownloadAndSaveImageMessageSuccessState extends ChatState {}
class DownloadAndSaveImageMessageFailureState extends ChatState {
  final String error;
  DownloadAndSaveImageMessageFailureState(this.error);
}

class SaveNetworkImageLoadingState extends ChatState {}
class SaveNetworkImageSuccessState extends ChatState {}

class DelayState extends ChatState {}

