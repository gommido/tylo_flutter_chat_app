import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../data/models/app_contact_model.dart';
import '../../presentation/controllers/chat_controller/chat_cubit.dart';
import '../../presentation/controllers/firestore_controller/fire_store_cubit.dart';
import '../../presentation/controllers/home_controller/home_cubit.dart';
import '../../presentation/controllers/local_storage_controller/local_storage_cubit.dart';
import '../components/custom_alert_dialog_widget.dart';
import '../components/custom_widgets/custom_snack_bar.dart';
import '../resources/constants/firebase_constants.dart';
import '../services/localization/localization.dart';
import 'navigator/navigator_pop.dart';

void blockContact({required BuildContext context}){
  showDialog(
    context: context,
    builder: (context) {
      final blockedContacts = context.read<LocalStorageCubit>().getBlockedContactsFromLocalStorage();
      final blocked = blockedContacts.where((contact)=> contact.id == context.read<ChatCubit>().otherChatUserId).toList();
      if(blocked.isNotEmpty){
        return CustomAlertDialogWidget(
          title: translate(context, AppStrings.doYouWantUnblock),
          onPressed: (){
            navigateAndPop(context);

            final contact = context.read<FireStoreCubit>().streamAppUser!;
            blockedContacts.removeWhere((contact)=> contact.id == contact.id);
            context.read<LocalStorageCubit>().saveBlockedContactsToLocalStorage(contacts: blockedContacts).then((onValue){
              context.read<LocalStorageCubit>().getBlockedContactsFromLocalStorage();
            });
            context.read<FireStoreCubit>().blockContact(blockedId: contact.id, isBlocking: false,);
            CustomToast.show(title: '${contact.phone} ${translate(context, AppStrings.removedFromBlockList)}');

            context.read<FireStoreCubit>().updateAppUserData(
              id:  context.read<FireStoreCubit>().streamAppUser!.id,
              field: FireBaseConstants.whoBlockMeList,
              value: FieldValue.arrayRemove([context.read<HomeCubit>().id]),
            );
          },
        );
      }
      return CustomAlertDialogWidget(
        title: translate(context, AppStrings.areYouSureToBlock),
        onPressed: (){
          navigateAndPop(context);
          final user = context.read<FireStoreCubit>().streamAppUser!;
          CustomToast.show(title: '${user.phone} ${translate(context, AppStrings.addedToBlockList)}');
          final contacts = blockedContacts.where(
                  (contact)=> contact.id == user.id).toList();
          if(contacts.isEmpty){
            AppContactModel appContactModel;
            context.read<FireStoreCubit>().blockContact(blockedId: user.id, isBlocking: true,);
            final storedContacts = context.read<LocalStorageCubit>().storedRegisteredContacts.where(
                    (contact)=> contact.id == user.id).toList();
            if(storedContacts.isEmpty){
              appContactModel = AppContactModel(id: user.id, name: user.name, phone: user.phone, image: user.photo, photoVisibility: '', whoBlockMeList: user.whoBlockMeList,);
            }else{
              appContactModel = AppContactModel(id: user.id, name: storedContacts.first.name, phone:user.phone, image: user.photo, photoVisibility: '', whoBlockMeList: [],);

            }
            blockedContacts.add(appContactModel);
            context.read<LocalStorageCubit>().saveBlockedContactsToLocalStorage(contacts: blockedContacts).then((value){
              context.read<LocalStorageCubit>().getBlockedContactsFromLocalStorage();
            });
          }
          context.read<FireStoreCubit>().updateAppUserData(
            id:  context.read<FireStoreCubit>().streamAppUser!.id,
            field: FireBaseConstants.whoBlockMeList,
            value: FieldValue.arrayUnion([context.read<HomeCubit>().id]),
          );
        },
      );
    },
  );
}