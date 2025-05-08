import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'internet_connection_state.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  InternetConnectionCubit() : super(InternetConnectionInitial()){
    _connectivity = Connectivity();
  }


  late Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  List<ConnectivityResult> connectivityResult  = [];


  Future<void> checkForInternetConnection()async{
    connectivityResult = await _connectivity.checkConnectivity();
    emit(CheckConnectivityState());
  }


  StreamSubscription<List<ConnectivityResult>> subscribeForNewConnection(){
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (event){
        connectivityResult = event;
        print(connectivityResult.first);
        emit(SubscribeNewConnectionState());
      },
    );
    return _connectivitySubscription;
  }

  Future<void> cancelConnectivitySubscription()async{
    await _connectivitySubscription.cancel();
    emit(CancelConnectivitySubscriptionState());
  }



}
