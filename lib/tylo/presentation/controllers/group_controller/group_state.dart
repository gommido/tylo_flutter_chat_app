part of 'group_cubit.dart';

@immutable
abstract class GroupState {}

class GroupInitial extends GroupState {}

class CreateGroupLoadingsState extends GroupState {}
class CreateGroupSuccessState extends GroupState {}
class CreateGroupFailureState extends GroupState {
  final String error;
  CreateGroupFailureState(this.error);
}

class CheckIsContactPickedState extends GroupState {}


class PickGroupMembersState extends GroupState {}

class AddContactToSelectedState extends GroupState {}

class RemoveContactFromSelectedState extends GroupState {}

class AddContactImageToSelectedState extends GroupState {}

class RemoveContactImageFromSelectedState extends GroupState {}

class ClearSelectedContactsState extends GroupState {}

class InitGroupNameControllerState extends GroupState {}
class DisposeGroupNameControllerState extends GroupState {}

class ClearGroupChatMessageTextState extends GroupState {}

class UpdateGroupDataLoadingState extends GroupState {}
class UpdateGroupDataSuccessState extends GroupState {}
class UpdateGroupDataFailureState extends GroupState {
  final String error;
  UpdateGroupDataFailureState(this.error);
}


class GetGroupDetailsSuccessState extends GroupState {}
class GetGroupDetailsFailureState extends GroupState {
  final String error;
  GetGroupDetailsFailureState(this.error);
}


class GetMyGroupsSuccessState extends GroupState {}
class GetMyGroupsFailureState extends GroupState {
  final String error;
  GetMyGroupsFailureState(this.error);
}

class SendGroupMessageSuccessState extends GroupState {}
class SendGroupMessageFailureState extends GroupState {
  final String error;
  SendGroupMessageFailureState(this.error);
}

class UpdateGroupMessageSuccessState extends GroupState {}
class UpdateGroupMessageFailureState extends GroupState {
  final String error;
  UpdateGroupMessageFailureState(this.error);
}


class SendAndUpdateGroupFileMessageSuccessState extends GroupState {}
class SendAndUpdateGroupFileMessageFailureState extends GroupState {
  final String error;
  SendAndUpdateGroupFileMessageFailureState(this.error);
}

class SetGroupLastMessageSuccessState extends GroupState {}
class SetGroupLastMessageFailureState extends GroupState {
  final String error;
  SetGroupLastMessageFailureState(this.error);
}

class GetGroupMessagesSuccessState extends GroupState {}
class GetGroupMessagesFailureState extends GroupState {
  final String error;
  GetGroupMessagesFailureState(this.error);
}

class AddOrRemoveContactFromGroupSuccessState extends GroupState {}
class AddOrRemoveContactFromGroupFailureState extends GroupState {
  final String error;
  AddOrRemoveContactFromGroupFailureState(this.error);
}

class GetGroupMembersSuccessState extends GroupState {}
class GetGroupMembersFailureState extends GroupState {
  final String error;
  GetGroupMembersFailureState(this.error);
}


class InitGroupChatMessageControllerState extends GroupState {}


class DisposeGroupChatMessageControllerState extends GroupState {}

class DeleteGroupMessageLoadingState extends GroupState {}
class DeleteGroupMessageSuccessState extends GroupState {}
class DeleteGroupMessageFailureState extends GroupState {
  final String error;
  DeleteGroupMessageFailureState(this.error);
}


class DeleteGroupLoadingState extends GroupState {}
class DeleteGroupSuccessState extends GroupState {}
class DeleteGroupFailureState extends GroupState {
  final String error;
  DeleteGroupFailureState(this.error);
}

class ClearMyGroupsListState extends GroupState {}

class GetVideoMessageThumbnailState extends GroupState {}
