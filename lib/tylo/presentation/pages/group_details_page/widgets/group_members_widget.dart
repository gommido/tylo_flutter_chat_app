import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_gesture_detector.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_list_view_widget.dart';
import 'package:tylo/tylo/core/components/loading_widget.dart';
import 'package:tylo/tylo/core/helper_functions/capitalize_all_words.dart';
import 'package:tylo/tylo/core/helper_functions/navigator/push_named_navigator.dart';
import 'package:tylo/tylo/core/resources/color_manager.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/presentation/controllers/chat_controller/chat_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_cached_network_image_widget.dart';
import '../../../../core/components/custom_circle_shape_widget.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/detect_language.dart';
import '../../../../core/resources/constants/app_routes.dart';

class GroupMembersWidget extends StatelessWidget {
  const GroupMembersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumerWidget<GroupCubit, GroupState>(
      listener: (context, state){},
      builder: (context, state){
        if(context.read<GroupCubit>().groupMembers == null){
          return const LoadingWidget(color: ColorManager.white);
        }
        return CustomListViewWidget(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: context.read<GroupCubit>().groupMembers!.length,
          separatorBuilder: (context, index) => CustomSizedBox(height: size.height / 50,),
          itemBuilder: (context, index){
            final member =  context.read<GroupCubit>().groupMembers![index];
            return CustomGestureDetector(
              onTap: (){
                context.read<ChatCubit>().setOtherChatUserId(member.id);
                pushNamed(route: AppRoutes.chatRoomPage, context: context,);
              },
              child: CustomRow(
                children: [
                  CustomCircleShapeWidget(
                    width: size.width / 8,
                    height: size.width / 8,
                    image: ClipOval(
                      child: CustomCachedNetworkImageWidget(
                        width: size.width / 8,
                        height: size.width / 8,
                        imageUrl: member.photoVisibility == AppStrings.everyone ? member.photo : '',
                        icon: Icons.person,
                      ),
                    ),
                  ),
                  CustomSizedBox(width: size.width / 50,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomBuilder(
                        builder: (context) {
                          final name = member.name.split(' ').first;
                          final isLatinWord = detectWordLanguage(name);
                          return CustomText(
                            data: isLatinWord ? capitalizeAllWords(name) : name,
                            style: Theme.of(context).textTheme.bodyMedium!,
                          );
                        }
                      ),
                      CustomText(
                        data: member.bio,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ColorManager.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
