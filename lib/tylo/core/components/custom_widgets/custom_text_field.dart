import 'package:flutter/material.dart';
import '../../resources/color_manager.dart';
import 'custom_sized_box.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final double height;
  final double width;
  VoidCallback? onTap;
  int? maxLines;
  int? maxLength;
  FocusNode? focusNode;
  bool? expands;
  InputBorder? border;
  void Function(String)? onChanged;
  Widget? prefix;
  CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.textInputType,
    required this.height,
    required this.width,
    this.maxLines,
    this.maxLength,
    this.expands = false,
    this.focusNode,
    this.border,
    this.onChanged,
    this.onTap,
    this.prefix,

  });

  @override
  Widget build(BuildContext context) {
  return CustomSizedBox(
      height: height,
      width: width,
      child: TextFormField(
        onTap: onTap,
        focusNode: focusNode,
        onTapOutside: (event){
          FocusManager.instance.primaryFocus!.unfocus();
        },
        textAlignVertical: TextAlignVertical.top,
        maxLines: maxLines,
        maxLength: maxLength,
        expands: expands!,
        controller: controller,
        keyboardType: textInputType,
        style: Theme.of(context).textTheme.bodySmall!,
        decoration: InputDecoration(
          prefix: prefix,
            hintText: label,
            hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: ColorManager.white.withOpacity(0.5),
            ),
            border: border ?? OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: ColorManager.primaryColor,
              ),
            ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
