import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tylo/tylo/core/resources/color_manager.dart';

import '../../presentation/controllers/file_picker_controller/file_picker_cubit.dart';
import '../helper_functions/navigator/navigator_pop.dart';
import 'custom_widgets/custom_container.dart';
import 'custom_widgets/custom_expanded.dart';
import 'custom_widgets/custom_gesture_detector.dart';
import 'custom_widgets/custom_icon.dart';
import 'custom_widgets/custom_row.dart';
import 'custom_widgets/custom_sized_box.dart';
import 'custom_widgets/custom_text.dart';

class CustomPickSourceImageWidget extends StatelessWidget {
  const CustomPickSourceImageWidget({super.key, required this.sourceName, required this.source, required this.icon, required this.type});
  final String sourceName;
  final ImageSource source;
  final IconData icon;
  final String type;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomExpanded(
      child: CustomGestureDetector(
        onTap: (){
          context.read<FilePickerCubit>().pickFile(source: source, type: type,);
          navigateAndPop(context);
        },
        child: CustomContainer(
          width: size.width,
          decoration: const BoxDecoration(
            color: ColorManager.transparent,
          ),
          child: CustomRow(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIcon(icon: icon, color: ColorManager.primaryColor,),
              CustomSizedBox(width: size.width / 50,),
              CustomText(
                data: sourceName,
                style: Theme.of(context).textTheme.bodySmall!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
