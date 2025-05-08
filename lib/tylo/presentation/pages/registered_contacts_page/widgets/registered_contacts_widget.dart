import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_builder.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_gesture_detector.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_list_view_widget.dart';
import 'package:tylo/tylo/core/helper_functions/navigator/push_named_and_replace.dart';
import 'package:tylo/tylo/core/resources/color_manager.dart';
import 'package:tylo/tylo/core/resources/constants/app_routes.dart';
import 'package:tylo/tylo/presentation/controllers/chat_controller/chat_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/local_storage_controller/local_storage_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_padding.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import 'contact_card_widget.dart';
import 'create_new_contact_widget.dart';
import 'no_contacts_widget.dart';

class RegisteredContactsWidget extends StatelessWidget {
  const RegisteredContactsWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<LocalStorageCubit, LocalStorageState>(
      listener: (context, state) {},
      builder: (context, state) {
        final size = MediaQuery.of(context).size;
        if(context.read<LocalStorageCubit>().storedRegisteredContacts.isNotEmpty){
          return CustomPadding(
            padding: const EdgeInsets.all(10.0),
            child: CustomListViewWidget(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: context.watch<LocalStorageCubit>().storedRegisteredContacts.length,
                separatorBuilder: (context, index)=> CustomSizedBox(height: size.height / 100,),
                itemBuilder: (context, index) {
                  final contact = context.read<LocalStorageCubit>().storedRegisteredContacts[index];
                  return CustomColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomBuilder(
                        builder: (context){
                          if(index == 0){
                            return const CreateNewContactWidget();
                          }
                          return CustomSizedBox();
                        },
                      ),
                      CustomGestureDetector(
                        onTap: (){
                          context.read<ChatCubit>().setOtherChatUserId(contact.id);
                          pushNamedAndReplace(route: AppRoutes.chatRoomPage, context: context,);
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
                      ),
                    ],
                  );
                }
            ),
          );
        }
        return const NoContactsWidget();
        },
    );
  }
}
