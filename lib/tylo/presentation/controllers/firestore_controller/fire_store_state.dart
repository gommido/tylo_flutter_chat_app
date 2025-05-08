part of 'fire_store_cubit.dart';

@immutable
abstract class FireStoreState {}

class FireStoreInitial extends FireStoreState {}

class SetProfileNameState extends FireStoreState {}

class CreateAppUserInDatabaseSuccessState extends FireStoreState {}
class CreateAppUserInDatabaseFailureState extends FireStoreState {
  final String error;
  CreateAppUserInDatabaseFailureState(this.error);
}

class CreateAppUserLoadingState extends FireStoreState {}
class CreateAppUserDelayState extends FireStoreState {}

class CreateAppUserSuccessState extends FireStoreState {}
class CreateAppUserFailureState extends FireStoreState {
  final String error;
  CreateAppUserFailureState(this.error);
}

class UpdateAppUserDataLoadingState extends FireStoreState {}
class UpdateAppUserDataSuccessState extends FireStoreState {}
class UpdateAppUserDataFailureState extends FireStoreState {
  final String error;
  UpdateAppUserDataFailureState(this.error);
}

class CheckIfUserExistByFieldLoadingState extends FireStoreState {}
class CheckIfUserExistByFieldSuccessState extends FireStoreState {}
class CheckIfUserExistByFieldFailureState extends FireStoreState {
  final String error;
  CheckIfUserExistByFieldFailureState(this.error);
}

class FollowUserSuccessState extends FireStoreState {}
class FollowUserFailureState extends FireStoreState {
  final String error;
  FollowUserFailureState(this.error);
}

class AddOrRemoveFromFollowersListSuccessState extends FireStoreState {}
class AddOrRemoveFromFollowersListFailureState extends FireStoreState {
  final String error;
  AddOrRemoveFromFollowersListFailureState(this.error);
}

class UpdateMyFollowingListSuccessState extends FireStoreState {}
class UpdateMyFollowingListFailureState extends FireStoreState {
  final String error;
  UpdateMyFollowingListFailureState(this.error);
}

class AddOrRemoveFromFavoritesSuccessState extends FireStoreState {}
class AddOrRemoveFromFavoritesFailureState extends FireStoreState {
  final String error;
  AddOrRemoveFromFavoritesFailureState(this.error);
}

class GetContactsFromFriendsListSuccessState extends FireStoreState {}
class GetContactsFromFriendsListFailureState extends FireStoreState {
  final String error;
  GetContactsFromFriendsListFailureState(this.error);
}

class GetMyChatsIdsSuccessState extends FireStoreState {}
class GetMyChatsIdsFailureState extends FireStoreState {
  final String error;
  GetMyChatsIdsFailureState(this.error);
}


class AddChatIdSuccessState extends FireStoreState {}
class AddChatIdFailureState extends FireStoreState {
  final String error;
  AddChatIdFailureState(this.error);
}

class UpdateAllUserReelsLikesCountSuccessState extends FireStoreState {}
class UpdateAllUserReelsLikesCountFailureState extends FireStoreState {
  final String error;
  UpdateAllUserReelsLikesCountFailureState(this.error);
}

class GetStreamAppUserDataSuccessState extends FireStoreState {}
class GetStreamAppUserDataFailureState extends FireStoreState {}


class GetCurrentUserDataSuccessState extends FireStoreState {}
class GetCurrentUserDataFailureState extends FireStoreState {
  final String error;
  GetCurrentUserDataFailureState(this.error);
}

class GetUserDataSuccessState extends FireStoreState {}
class GetUserDataFailureState extends FireStoreState {
  final String error;
  GetUserDataFailureState(this.error);
}

class SetNameWarningShownState extends FireStoreState {}


class DeleteFirebaseDocumentSuccessState extends FireStoreState {}
class DeleteFirebaseDocumentFailureState extends FireStoreState {
  final String error;
  DeleteFirebaseDocumentFailureState(this.error);
}

class CheckUserNameTakenState extends FireStoreState {}

class SetIsAppUserDataState extends FireStoreState {}

class SetProfileImageUploadingState extends FireStoreState {}

class BlockContactSuccessState extends FireStoreState {}
class BlockContactFailureState extends FireStoreState {
  final String error;
  BlockContactFailureState(this.error);
}

class GetOnlineUsersSuccessState extends FireStoreState {}
class GetOnlineUsersFailureState extends FireStoreState {
  final String error;
  GetOnlineUsersFailureState(this.error);
}

