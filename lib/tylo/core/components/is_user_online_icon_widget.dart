import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/controllers/firestore_controller/fire_store_cubit.dart';
import '../../presentation/controllers/internet_connection_controller/internet_connection_cubit.dart';
import '../../presentation/pages/chat_room_page/widgets/online_status.dart';
import 'custom_widgets/custom_builder.dart';
import 'custom_widgets/custom_sized_box.dart';

class IsUserOnlineIconWidget extends StatelessWidget {
  const IsUserOnlineIconWidget({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return CustomBuilder(
      builder: (context){
        if(!context.watch<InternetConnectionCubit>().connectivityResult.contains(ConnectivityResult.none)){
          final onlineUsers = context.read<FireStoreCubit>().onlineUsers.where((user)=> user.id == id).toList();
          if(onlineUsers.isNotEmpty){
            return const OnlineStatusWidget();
          }
        }
        return CustomSizedBox();
      },
    );
  }
}
