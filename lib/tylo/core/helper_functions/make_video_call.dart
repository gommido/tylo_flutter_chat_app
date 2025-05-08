import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../presentation/controllers/call_controller/call_cubit.dart';
import '../../presentation/controllers/chat_controller/chat_cubit.dart';
import '../../presentation/controllers/firestore_controller/fire_store_cubit.dart';
import '../../presentation/controllers/home_controller/home_cubit.dart';
import '../../presentation/controllers/local_storage_controller/local_storage_cubit.dart';
import '../components/custom_widgets/custom_snack_bar.dart';
import '../resources/constants/app_routes.dart';
import '../services/localization/localization.dart';
import 'capitalize_all_words.dart';
import 'detect_language.dart';
import 'navigator/push_named_navigator.dart';

void makeVideoCall({required BuildContext context,}){
  final blockList = context.read<LocalStorageCubit>().getBlockedContactsFromLocalStorage();
  final blocked = blockList.where((contact) => contact.id == context.read<ChatCubit>().otherChatUserId).toList();
  if(blocked.isEmpty){
    final contact = context.read<FireStoreCubit>().streamAppUser!;
    if(!contact.blockList.contains(context.read<HomeCubit>().id)){
      final isLatinWord = detectWordLanguage(contact.name.split(' ').first);
      if(contact.lastSeen == null){
        pushNamed(route: AppRoutes.videoCallPage, context: context, arguments: true,);
        context.read<CallCubit>().setIsRoomJoinedData(isJoined: true);
        context.read<CallCubit>().createRoom(
          callerId: context.read<HomeCubit>().id,
          callReceiverId: context.read<FireStoreCubit>().streamAppUser!.id,
          callerName: context.read<FireStoreCubit>().currentAppUser!.name,
          callerImage: context.read<FireStoreCubit>().currentAppUser!.photo,
        );
      }else{
        CustomToast.show(title: '${isLatinWord ?
        capitalizeAllWords(contact.name.split(' ').first) :
        contact.name.split(' ').first} ${translate(context, AppStrings.currentlyNotAvailable)}', toastLength: Toast.LENGTH_LONG, isCenter: true,);
      }
    }else{
      CustomToast.show(title: translate(context, AppStrings.sorryContactBlockedYou), toastLength: Toast.LENGTH_LONG, isCenter: true,);
    }
  }else{
   CustomToast.show(title: translate(context, AppStrings.youBlockedThisContact), toastLength: Toast.LENGTH_LONG, isCenter: true,);
  }
}