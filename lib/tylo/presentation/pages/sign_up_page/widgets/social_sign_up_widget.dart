import 'package:flutter/material.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import 'sign_up_container_widget.dart';

class SocialSignUpWidget extends StatelessWidget {
  const SocialSignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomRow(
      children: const [
        SignUpContainerWidget( icon: Icons.email, isGoogleLogin: true,),
        SignUpContainerWidget( icon: Icons.facebook, isGoogleLogin: false,),
      ],
    );
  }
}
