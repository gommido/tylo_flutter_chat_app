import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/app_contact.dart';
import '../../presentation/controllers/chat_controller/chat_cubit.dart';
import '../../presentation/controllers/home_controller/home_cubit.dart';
import '../../presentation/pages/registered_contacts_page/widgets/contact_card_widget.dart';
import '../helper_functions/navigator/push_named_navigator.dart';
import '../resources/color_manager.dart';
import '../resources/constants/app_routes.dart';
import 'custom_widgets/custom_container.dart';
import 'custom_widgets/custom_gesture_detector.dart';
import 'custom_widgets/custom_list_view_widget.dart';
import 'custom_widgets/custom_padding.dart';
import 'custom_widgets/custom_sized_box.dart';

class CustomContactsListWidget extends StatelessWidget {
  const CustomContactsListWidget({super.key, required this.contacts});
  final List<AppContact> contacts;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomPadding(
      padding: const EdgeInsets.all(10.0),
      child: CustomListViewWidget(
        itemCount: contacts.length,
        separatorBuilder: (context, index)=> CustomSizedBox(height: size.height / 50,),
        itemBuilder: (context, index){
          final contact = contacts[index];
          return CustomGestureDetector(
            onTap: (){
              context.read<ChatCubit>().setOtherChatUserId(contact.id);

              pushNamed(route: AppRoutes.chatRoomPage, context: context,);
              context.read<HomeCubit>().tapToSearch();
              context.read<HomeCubit>().clearSearchedList();
            },
            child: CustomContainer(
              width: size.width,
              decoration: const BoxDecoration(
                color: ColorManager.transparent,
              ),
              child: ContactCardWidget(
                contact: contact,
                isRegistered: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
