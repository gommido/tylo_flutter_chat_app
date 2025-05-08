import 'package:flutter/material.dart';

import 'custom_widgets/custom_icon.dart';
import 'custom_widgets/custom_icon_button.dart';

class DeleteIconButtonWidget extends StatelessWidget {
  const DeleteIconButtonWidget({super.key, required this.onPressed});
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: onPressed,
      icon: CustomIcon(icon: Icons.delete,),
    );
  }
}
