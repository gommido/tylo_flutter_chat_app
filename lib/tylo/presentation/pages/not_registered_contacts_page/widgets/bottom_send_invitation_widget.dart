import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/presentation/controllers/local_storage_controller/local_storage_cubit.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../../core/services/localization/localization.dart';
import '../../../controllers/contacts_controller/contacts_cubit.dart';

class BottomSendInvitationWidget extends StatelessWidget {
  const BottomSendInvitationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumerWidget<ContactsCubit, ContactsState>(
      listener: (context, state){},
      builder: (context, state){
        return CustomBuilder(
          builder: (context){
            if(context.read<ContactsCubit>().selectedContact != null){
              return CustomGestureDetector(
                onTap: (){
                  context.read<ContactsCubit>().sendSMS(
                    phoneNumber: context.read<LocalStorageCubit>().storedNotRegisteredContacts[context.read<ContactsCubit>().selectedContact!].phone,
                    invitation: '${translate(context, AppStrings.iAmUsingTylo)}: ${AppStrings.playStoreLink}${AppStrings.packageName}',
                  );
                },
                child: CustomContainer(
                  alignment: Alignment.center,
                  width: size.width,
                  height: size.height / 15,
                  decoration: const BoxDecoration(
                    color: ColorManager.primaryColor,
                  ),
                  child: CustomRow(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        data: translate(context, AppStrings.invite),
                        style: Theme.of(context).textTheme.bodyLarge!,
                      ),
                      CustomSizedBox(width: size.width / 50,),
                      CustomIcon(icon: Icons.arrow_forward, color: ColorManager.white,)
                    ],
                  ),
                ),
              );
            }
            return CustomSizedBox();
          },
        );
      },
    );
  }
}
