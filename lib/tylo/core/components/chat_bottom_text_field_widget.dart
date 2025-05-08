import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../resources/color_manager.dart';
import '../services/localization/localization.dart';
import 'custom_widgets/custom_sized_box.dart';

class ChatBottomTextFieldWidget extends StatelessWidget {
  const ChatBottomTextFieldWidget({super.key, required this.focusNode, required this.controller, this.onChanged, this.onTap});
  final FocusNode focusNode;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomSizedBox(
      height: size.height / 18,
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        maxLines: 1,
        onChanged: onChanged,
        style: Theme.of(context).textTheme.bodyMedium,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.bodySmall!,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          filled: true,
          prefix: CustomSizedBox(width: size.width / 20,),
          fillColor: ColorManager.messageTextFieldBGColor,
          contentPadding: EdgeInsets.zero,
          hintText: translate(context,AppStrings.textMessage),
          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: ColorManager.white.withOpacity(0.3),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
