import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/helper_functions/capitalize_all_words.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';
import '../../../../core/components/custom_cached_network_image_widget.dart';
import '../../../../core/components/custom_circle_shape_widget.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';

class GroupOwnerWidget extends StatelessWidget {
  const GroupOwnerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomRow(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomIcon(icon: Icons.person, ),
        CustomSizedBox(width: size.width / 50,),
        CustomColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              data: translate(context, AppStrings.groupOwner),
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
            CustomSizedBox(height: size.height / 100,),
            CustomRow(
              children: [
                CustomCircleShapeWidget(
                  width: size.width / 10,
                  height: size.width / 10,
                  image: ClipOval(
                    child: CustomCachedNetworkImageWidget(
                      width: size.width / 10,
                      height: size.width / 10,
                      imageUrl:  context.read<GroupCubit>().group!.ownerImage,
                      icon: Icons.person,
                    ),
                  ),
                ),
                CustomSizedBox(width: size.height / 100,),
                CustomText(
                  data: capitalizeAllWords(context.read<GroupCubit>().group!.ownerName),
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
