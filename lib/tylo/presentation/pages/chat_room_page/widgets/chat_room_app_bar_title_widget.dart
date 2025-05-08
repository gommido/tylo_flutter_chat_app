import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/animated_dots.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_builder.dart';
import 'package:tylo/tylo/core/resources/color_manager.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/resources/font_manager.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';
import 'package:tylo/tylo/presentation/pages/chat_room_page/widgets/online_status.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_expanded.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/components/stream_user_profile_image_widget.dart';
import '../../../../core/helper_functions/date_format.dart';
import '../../../../core/helper_functions/navigator/push_named_navigator.dart';
import '../../../../core/resources/constants/app_routes.dart';
import '../../../controllers/home_controller/home_cubit.dart';
import '../../../controllers/internet_connection_controller/internet_connection_cubit.dart';
import '../../../../core/components/second_user_name_widget.dart';

class  ChatRoomAppBarTitleWidget extends StatelessWidget {
  const  ChatRoomAppBarTitleWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<FireStoreCubit, FireStoreState>(
      listener: (context, state){},
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        if(context.read<FireStoreCubit>().streamAppUser != null){
          return CustomGestureDetector(
            onTap: (){
              pushNamed(route: AppRoutes.profileDetailsPage, context: context,);
            },
            child: CustomContainer(
              width: size.width,
              decoration: const BoxDecoration(
                color: ColorManager.transparent,
              ),
              child: CustomRow(
                children: [
                  StreamUserProfileImageWidget(
                    width: size.width / 10,
                    height: size.width / 10,
                  ),
                  CustomSizedBox(width: size.width / 50,),
                  CustomExpanded(
                    child: CustomColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomBuilder(
                          builder: (context) {
                            return CustomRow(
                              children: [
                                const SecondUserNameWidget(),
                                CustomSizedBox(width: size.width / 50,),
                                CustomBuilder(
                                    builder: (context) {
                                      if(context.read<FireStoreCubit>().streamAppUser!.lastSeen == null){
                                        return const OnlineStatusWidget();
                                      }
                                      return CustomSizedBox();
                                    }
                                ),
                              ],
                            );
                          }
                        ),
                        CustomBuilder(
                          builder: (context){
                            if(!context.watch<InternetConnectionCubit>().connectivityResult.contains(ConnectivityResult.none)){
                              if(context.read<FireStoreCubit>().streamAppUser != null){
                                if(context.watch<FireStoreCubit>().streamAppUser!.onlineVisibility == AppStrings.everyone){
                                  if(context.read<FireStoreCubit>().streamAppUser!.currentChatRoom.isNotEmpty){
                                    if(context.read<HomeCubit>().id == context.read<FireStoreCubit>().streamAppUser!.currentChatRoom){
                                      if(context.watch<FireStoreCubit>().streamAppUser!.isTyping){
                                        return CustomRow(
                                          children: [
                                            CustomText(
                                              data: translate(context, AppStrings.typingNow),
                                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                  color: ColorManager.green,
                                                  fontSize: FontManager.s10
                                              ),
                                            ),
                                            const AnimatedDots(),
                                          ],
                                        );
                                      }
                                      return CustomText(
                                        data: translate(context, AppStrings.iAmHere),
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            color: ColorManager.green,
                                            fontSize: FontManager.s10
                                        ),
                                      );
                                    }
                                    return CustomText(
                                      data: translate(context, AppStrings.away),
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                          color: ColorManager.primaryColor,
                                          fontSize: FontManager.s10
                                      ),
                                    );
                                  }else{
                                    if(context.watch<FireStoreCubit>().streamAppUser!.lastSeen == null){
                                      return CustomText(
                                        data: translate(context, AppStrings.away),
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                          color: ColorManager.primaryColor,
                                          fontSize: FontManager.s10,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    }
                                    return CustomText(
                                      data: '${translate(context, AppStrings.lastSeen)} ${formatChatTimesInDays(context.read<FireStoreCubit>().streamAppUser!.lastSeen!)} ${formatChatTimesInHours(context.read<FireStoreCubit>().streamAppUser!.lastSeen!)}',
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: ColorManager.grey,
                                        fontSize: FontManager.s08,
                                      ),
                                    );
                                  }
                                }


                              }
                            }
                            return CustomSizedBox();

                          },
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return CustomSizedBox();
      },
    );
  }
}
