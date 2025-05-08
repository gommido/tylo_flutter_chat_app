import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/color_manager.dart';
import 'package:tylo/tylo/core/resources/font_manager.dart';

import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_padding.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';


class ContactsBodyWidget extends StatelessWidget {
  const ContactsBodyWidget({super.key, required this.title, required this.widget, required this.contactsNumber,});
  final String title;
  final Widget widget;
  final String contactsNumber;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomContainer(
            width: size.width,
            height: size.height / 18,
            alignment: AlignmentDirectional.topStart,
            decoration: BoxDecoration(
              color: ColorManager.teal.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5)
            ),
            child: CustomPadding(
              padding: const EdgeInsets.all(8.0),
              child: CustomRow(
                children: [
                  CustomText(
                    data: title,
                    style: Theme.of(context).textTheme.bodyMedium!,),
                  SizedBox(width: size.width / 50,),
                  CustomText(
                    data: '($contactsNumber)',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorManager.grey,
                      fontSize: FontManager.s16,
                    ),
                  ),
                ],
              )
            ),
        ),
        widget
      ],
    );  }
}
