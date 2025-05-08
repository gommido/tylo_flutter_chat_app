import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_column.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_gesture_detector.dart';
import 'package:tylo/tylo/core/resources/color_manager.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/navigator/push_named_navigator.dart';
import '../../../../core/resources/constants/app_routes.dart';
import '../../last_seen_online_status_page/widgets/last_seen_and_online_status_app_bar_title_widget.dart';

class LastSeenAndOnlineStatusWidget extends StatelessWidget {
  const LastSeenAndOnlineStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomGestureDetector(
      onTap: (){
        pushNamed(route: AppRoutes.lastSeenAndOnlineStatusPage, context: context);

      },
      child: CustomContainer(
        width: size.width,
        decoration: const BoxDecoration(
          color: ColorManager.transparent,
        ),
        child: CustomColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LastSeenAndOnlineStatusAppBarTitleWidget(),
            BlocConsumerWidget<FireStoreCubit, FireStoreState>(
              listener: (context, state){},
              builder: (context, state){
                return CustomText(
                  data: context.watch<FireStoreCubit>().currentAppUser!.onlineVisibility,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: ColorManager.grey,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
