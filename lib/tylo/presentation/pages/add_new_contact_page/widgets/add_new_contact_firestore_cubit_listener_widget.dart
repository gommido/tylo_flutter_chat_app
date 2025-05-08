import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/helper_functions/navigator/navigator_pop.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../../core/resources/constants/firebase_constants.dart';
import '../../../../core/services/shared_preference/shared_prefs_manager.dart';
import '../../../../domain/entities/app_contact.dart';
import '../../../controllers/contacts_controller/contacts_cubit.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';
import '../../../controllers/local_storage_controller/local_storage_cubit.dart';

class AddNewContactFireStoreCubitListenerWidget extends StatelessWidget {
  const AddNewContactFireStoreCubitListenerWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<FireStoreCubit, FireStoreState>(
      listener: (context, state){
        if(state is CheckIfUserExistByFieldSuccessState){
          List<AppContact> contacts = [];
          if(context.read<FireStoreCubit>().existUser != null){
            final user = context.read<FireStoreCubit>().existUser;
            Map<String, bool> photoVisibility = {};
            AppContact appContact = AppContact(
              id: user!.id,
              name: context.read<ContactsCubit>().nameController.text,
              phone: user.phone,
              image: user.photo,
              photoVisibility: user.photoVisibility,
              whoBlockMeList: user.whoBlockMeList,
            );
            contacts.add(appContact);
            contacts.addAll(context.read<LocalStorageCubit>().storedRegisteredContacts);
            context.read<LocalStorageCubit>().saveRegisteredContactsToLocalStorage(contacts: contacts).then((value){
              context.read<LocalStorageCubit>().getRegisteredContactsFromLocalStorage();
              context.read<FireStoreCubit>().updateAppUserData(
                id: context.read<HomeCubit>().id,
                field: FireBaseConstants.contacts,
                value: FieldValue.arrayUnion([user.id]),
              );
            });
            switch(context.read<FireStoreCubit>().existUser!.photoVisibility){
              case AppStrings.everyone: photoVisibility[user.id] = true;
              case AppStrings.nobody: photoVisibility[user.id] = false;
              case AppStrings.contacts:
                if(user.contacts.contains(context.read<HomeCubit>().id)){
                  photoVisibility[user.id] = true;
                }else{
                  photoVisibility[user.id] = false;
                }
            }
            final visibility = SharedPrefsManager.getMapData(key: AppStrings.photoVisibility);
            visibility.addAll(photoVisibility);
            SharedPrefsManager.saveMapData(key: AppStrings.photoVisibility, map: visibility).then((value){});
          }else{
            AppContact appContact = AppContact(
              id: '',
              name:  context.read<ContactsCubit>().nameController.text,
              phone:  context.read<ContactsCubit>().phoneNumberController.text,
              image: '',
              photoVisibility: '',
              whoBlockMeList: [],
            );
            contacts.add(appContact);
            contacts.addAll(context.read<LocalStorageCubit>().storedNotRegisteredContacts);

            context.read<LocalStorageCubit>().saveNotRegisteredContactsToLocalStorage(contacts: contacts).then((value){
              context.read<LocalStorageCubit>().getNotRegisteredContactsFromLocalStorage();
            });
          }
          navigateAndPop(context);
        }

      },
      builder: (context, state){
        return child;
      },
    );
  }
}
