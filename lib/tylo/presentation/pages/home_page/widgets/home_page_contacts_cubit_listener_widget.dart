import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/firebase_constants.dart';
import 'package:tylo/tylo/presentation/controllers/contacts_controller/contacts_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';

import '../../../../core/components/bloc_consumer_widget.dart';

class HomePageContactsCubitListenerWidget extends StatelessWidget {
  const HomePageContactsCubitListenerWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ContactsCubit, ContactsState>(
      listener: (context, state){
        if(state is GetPhoneContactsSuccessState){
          if(context.read<FireStoreCubit>().currentAppUser != null){
            if(context.read<FireStoreCubit>().currentAppUser!.contacts.isEmpty){
              context.read<FireStoreCubit>().updateAppUserData(
                id: context.read<HomeCubit>().id,
                field: FireBaseConstants.contacts,
                  value: FieldValue.arrayUnion(context.read<ContactsCubit>().contactsIds),
              );
            }else{
              final contacts = <dynamic>{...context.read<FireStoreCubit>().currentAppUser!.contacts, ... context.read<ContactsCubit>().contactsIds}.toList();
              if(contacts.isNotEmpty){
                context.read<FireStoreCubit>().updateAppUserData(
                  id: context.read<HomeCubit>().id,
                  field: FireBaseConstants.contacts,
                  value: FieldValue.arrayUnion(contacts),
                );
              }
            }
          }
        }
      },
      builder: (context, state){
        return child;
      },
    );
  }
}
