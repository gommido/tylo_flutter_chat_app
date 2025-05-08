import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/color_manager.dart';
import 'package:tylo/tylo/presentation/pages/openning_page/widgets/opening_page_app_logo_widget.dart';
import 'package:tylo/tylo/presentation/pages/openning_page/widgets/opening_page_gif_widget.dart';
import 'package:tylo/tylo/presentation/pages/openning_page/widgets/opening_page_slogan_widget.dart';
import 'package:tylo/tylo/presentation/pages/openning_page/widgets/opening_page_start_button_widget.dart';
import '../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../core/components/custom_widgets/custom_stack.dart';


class OpeningPage extends StatelessWidget {
  const OpeningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: ColorManager.black,
      body: CustomStack(
        children: const [
          OpeningPageGifWidget(),
          OpeningPageAppLogoWidget(),
          OpeningPageSloganWidget(),
          OpeningPageStartButtonWidget(),
        ],
      ),
    );
  }
}
