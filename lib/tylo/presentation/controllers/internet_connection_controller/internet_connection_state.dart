part of 'internet_connection_cubit.dart';

@immutable
abstract class InternetConnectionState {}

class InternetConnectionInitial extends InternetConnectionState {}

class CheckConnectivityState extends InternetConnectionState {}
class SubscribeNewConnectionState extends InternetConnectionState {}
class CancelSubscriptionState extends InternetConnectionState {}
class UpdateConnectionStatusState extends InternetConnectionState {}

class ToggleCheckingTimeOutState extends InternetConnectionState {}

class CancelConnectivitySubscriptionState extends InternetConnectionState {}
