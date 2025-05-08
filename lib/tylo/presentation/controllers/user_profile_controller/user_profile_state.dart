part of 'user_profile_cubit.dart';

@immutable
abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class InitVisibilityState extends UserProfileState {}

class SetVisibilityState extends UserProfileState {}

class InitUserNameControllerState extends UserProfileState {}
class DisposeUserNameControllerState extends UserProfileState {}
