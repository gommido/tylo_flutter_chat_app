import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';

import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/date_format.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../chat_room_page/widgets/online_status.dart';

class ContactOnlineStatusWidget extends StatelessWidget {
  const ContactOnlineStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumerWidget<FireStoreCubit, FireStoreState>(
        listener: (context, state){},
        builder: (context, state){
          return CustomBuilder(
            builder: (context){
              if(context.watch<FireStoreCubit>().streamAppUser!.lastSeen != null){
                return CustomText(
                  data: '${translate(context, AppStrings.lastSeen)} ${formatChatTimesInDays(context.read<FireStoreCubit>().streamAppUser!.lastSeen!)}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: ColorManager.grey,
                  ),
                );
              }
              return  CustomRow(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    data: translate(context, AppStrings.online),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorManager.green,
                    ),
                  ),
                  CustomSizedBox(width: size.width / 50,),
                  const OnlineStatusWidget(),
                ],
              );
            },
          );
        },
    );
  }
}
