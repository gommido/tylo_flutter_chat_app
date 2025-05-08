import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_circle_shape_widget.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_cached_network_image_widget.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/group_controller/group_cubit.dart';

class GroupChatRoomAppBarImageWidget extends StatelessWidget {
  const GroupChatRoomAppBarImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<GroupCubit, GroupState>(
      listener: (context, state){},
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        return CustomCircleShapeWidget(
            width: size.width / 10,
            height: size.width / 10,
            image: CustomBuilder(
              builder: (context){
                if(context.read<GroupCubit>().group!.image.isNotEmpty){
                  return ClipOval(
                    child: CustomCachedNetworkImageWidget(
                      width: size.width / 10,
                      height: size.width / 10,
                      imageUrl: context.read<GroupCubit>().group!.image,
                      icon: Icons.person,
                    ),
                  );
                }
                return CustomIcon(icon: Icons.group, color: ColorManager.grey,);
              },
            )
        );
      },
    );
  }
}
