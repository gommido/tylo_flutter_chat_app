import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/firebase_constants.dart';
import 'package:tylo/tylo/presentation/controllers/local_storage_controller/local_storage_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_modal_progress_hud.dart';
import '../../../controllers/call_controller/call_cubit.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/contacts_controller/contacts_cubit.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';
import '../../../controllers/group_controller/group_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';

class HomePageHomeCubitListenerWidget extends StatelessWidget {
  const HomePageHomeCubitListenerWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<FireStoreCubit, FireStoreState>(
      listener: (context, state){
        if(state is GetCurrentUserDataSuccessState){
          final contacts = context.read<FireStoreCubit>().currentAppUser!.contacts as List<String>;
          if(contacts.isNotEmpty){
            context.read<FireStoreCubit>().getOnlineUsers(
              ids: contacts,
            );
          }
        }

      },
      builder: (context, state){
        return BlocConsumerWidget<HomeCubit, HomeState>(
          listener: (context, state){
            if(state is GetCurrentUserIdState){
              context.read<FireStoreCubit>().updateAppUserData(
                id: BlocProvider.of<HomeCubit>(context, listen: false).id,
                field: FireBaseConstants.lastSeen,
                value: null,
              );
              context.read<FireStoreCubit>().getCurrentUserAsStream(id: context.read<HomeCubit>().id);
              BlocProvider.of<ContactsCubit>(context, listen: false).getPermissionStatus(id: context.read<HomeCubit>().id);
              BlocProvider.of<ChatCubit>(context, listen: false).getMyChatsLastMessages(id: context.read<HomeCubit>().id);
              BlocProvider.of<ChatCubit>(context, listen: false).getUnSeenNewChatsCount(id: context.read<HomeCubit>().id);
              BlocProvider.of<CallCubit>(context).getCallRoom(
                  userId: context.read<HomeCubit>().id,
                  field: FireBaseConstants.callReceiverId);
              BlocProvider.of<CallCubit>(context, listen: false).getMyCalls(userId: context.read<HomeCubit>().id);
              BlocProvider.of<GroupCubit>(context, listen: false).getMyGroups(id: context.read<HomeCubit>().id);
              BlocProvider.of<LocalStorageCubit>(context, listen: false).saveBlockedContactsToLocalStorage(contacts: []);
            }

          },
          builder: (context, state){
            return CustomModalProgressHUD(
              inAsyncCall: state is LogOutLoadingLoadingState,
              child: child,
            );
          },
        );
      },
    );
  }
}
