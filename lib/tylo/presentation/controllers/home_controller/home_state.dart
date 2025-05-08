part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class InitCurrentIndexState extends HomeState {}

class GetCurrentUserIdState extends HomeState {}

class InitTabControllerState extends HomeState {}

class GetCurrentTabIndexState extends HomeState {}

class TapToSearchState extends HomeState {}

class SearchForContactsState extends HomeState {}

class PressDeleteLongPressState extends HomeState {}

class ChangeAppLanguageState extends HomeState {}

class LogOutLoadingLoadingState extends HomeState {}
class LogOutLoadingSuccessState extends HomeState {}

class GetPageTypeWhenNavigateState extends HomeState {}

