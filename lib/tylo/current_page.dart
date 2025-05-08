import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';
import 'package:tylo/tylo/core/services/shared_preference/shared_prefs_manager.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/internet_connection_controller/internet_connection_cubit.dart';
import 'package:tylo/tylo/presentation/pages/home_page/home_layout_page.dart';
import 'package:tylo/tylo/presentation/pages/openning_page/opening_page.dart';

import 'core/resources/constants/app_strings.dart';
import 'core/resources/constants/firebase_constants.dart';



class CurrentPage extends StatelessWidget {
  const CurrentPage({super.key});

  @override
  Widget build(BuildContext context) {
    if(SharedPrefsManager.getBoolData(key: AppStrings.isCreated) != null && SharedPrefsManager.getBoolData(key: AppStrings.isCreated)!){
      return BlocConsumerWidget<InternetConnectionCubit, InternetConnectionState>(
        listener: (context, state){
          if(state is SubscribeNewConnectionState && !context.read<InternetConnectionCubit>().connectivityResult.contains(ConnectivityResult.none)){
            context.read<FireStoreCubit>().updateAppUserData(
              id: context.read<HomeCubit>().id,
              field: FireBaseConstants.lastSeen,
              value: null,
            );
          }
        },
        builder: (context, state){
          return const HomeLayoutPage();
        },
      );
    }
    return const OpeningPage();
  }
}
