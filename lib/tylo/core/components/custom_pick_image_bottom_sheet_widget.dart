import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import '../resources/color_manager.dart';
import '../services/localization/localization.dart';
import 'custom_pick_source_image_widget.dart';
import 'custom_widgets/custom_column.dart';
import 'custom_widgets/custom_container.dart';
import 'custom_widgets/custom_row.dart';
import 'custom_widgets/custom_sized_box.dart';
import 'custom_widgets/custom_text.dart';

class CustomPickImageBottomSheetWidget extends StatelessWidget {
  const CustomPickImageBottomSheetWidget({super.key, required this.type, required this.sourceName});
  final String type;
  final String sourceName;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomContainer(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: size.width,
      height: size.height / 6,
      child: CustomColumn(
        children: [
          CustomText(
            data: '.. $sourceName ..',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: ColorManager.white.withOpacity(0.5)
            ),
          ),
          CustomSizedBox(height: size.height / 50,),
          CustomRow(
            children: [
              CustomPickSourceImageWidget(
                sourceName: translate(context, AppStrings.gallery),
                source: ImageSource.gallery,
                icon: Icons.image,
                type: type,
              ),
              CustomContainer(
                width: size.width / 100,
                height: size.height / 20,
                decoration: BoxDecoration(
                    color: ColorManager.white.withOpacity(0.2)
                ),
              ),
              CustomPickSourceImageWidget(
                sourceName: translate(context, AppStrings.camera),
                source: ImageSource.camera,
                icon: Icons.camera_alt,
                type: type,
              ),

            ],
          ),
        ],
      ),
    );
  }
}
