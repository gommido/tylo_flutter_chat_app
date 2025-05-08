import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_divider.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_gesture_detector.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_scaffold.dart';
import 'package:tylo/tylo/core/resources/constants/app_languages.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/shared_preference/shared_prefs_manager.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';
import 'package:tylo/tylo/presentation/pages/settings_page/widgets/chosen_language_widget.dart';
import 'package:tylo/tylo/presentation/pages/settings_page/widgets/language_title_widget.dart';
import '../../../core/components/bloc_consumer_widget.dart';
import '../../../core/components/custom_widgets/custom_app_bar.dart';
import '../../../core/components/custom_widgets/custom_container.dart';
import '../../../core/components/custom_widgets/custom_list_view_widget.dart';
import '../../../core/components/custom_widgets/custom_padding.dart';
import '../../../core/components/custom_widgets/custom_row.dart';
import '../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../core/components/custom_widgets/custom_spacer.dart';
import '../../../core/helper_functions/navigator/navigator_pop.dart';
import '../../../core/resources/color_manager.dart';
import 'widgets/app_language_app_bar_title_widget.dart';

class AppLanguagePage extends StatelessWidget {
  const AppLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(
        context: context,
        title: const AppLanguageAppBarTitleWidget(),
        onPressed: (){
          navigateAndPop(context);
        },
      ),
      body: BlocConsumerWidget<HomeCubit, HomeState>(
        listener: (context, state){},
        builder: (context, state){
          final size = MediaQuery.of(context).size;
          return CustomPadding(
            padding: const EdgeInsets.all(8.0),
            child: CustomListViewWidget(
              itemCount: languages.length,
              separatorBuilder: (context, index) => CustomDivider(color: ColorManager.white.withOpacity(0.05)),
              itemBuilder: (context, index){
                return CustomGestureDetector(
                  onTap: (){
                    SharedPrefsManager.saveStringData(key: AppStrings.language, value: languages[index][AppStrings.tag]).then((value){
                      context.read<HomeCubit>().onChangeAppLanguage(languages[index][AppStrings.tag]);
                    });
                  },
                  child: CustomContainer(
                    width: size.width,
                    decoration: const BoxDecoration(
                        color: ColorManager.transparent
                    ),
                    child: CustomRow(
                      children: [
                        CustomSizedBox(width: size.width / 50,),
                        LanguageTitleWidget(language: languages[index],),
                        const CustomSpacer(),
                        ChosenLanguageWidget(language: languages[index],),
                        CustomSizedBox(width: size.width / 50,),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
