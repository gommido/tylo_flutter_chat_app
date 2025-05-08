import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import '../../../presentation/controllers/internet_connection_controller/internet_connection_cubit.dart';
import '../../services/localization/localization.dart';
import 'custom_snack_bar.dart';

class CustomInternetChecker{
  static void checkInternetAvailability({
    required BuildContext context,
    required VoidCallback onInternetAvailable,
    bool? isShowing,
}){
    if(!context.read<InternetConnectionCubit>().connectivityResult.contains(ConnectivityResult.none)){
      onInternetAvailable();
    }else{
      if(isShowing == null){
        CustomToast.show(
          title: translate(context, AppStrings.noInternetConnection),
        );
      }
    }
  }
}