import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_builder.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_pop_scope.dart';
import 'package:tylo/tylo/presentation/pages/settings_page/widgets/account_settings_body_widget.dart';
import 'package:tylo/tylo/presentation/pages/settings_page/widgets/account_settings_title_widget.dart';
import 'package:tylo/tylo/presentation/pages/settings_page/widgets/app_settings_body_widget.dart';
import 'package:tylo/tylo/presentation/pages/settings_page/widgets/app_settings_title.dart';
import 'package:tylo/tylo/presentation/pages/settings_page/widgets/delete_account_widget.dart';
import 'package:tylo/tylo/presentation/pages/settings_page/widgets/log_out_title_widget.dart';
import '../../../core/components/bloc_consumer_widget.dart';
import '../../../core/components/custom_widgets/custom_column.dart';
import '../../../core/components/custom_widgets/custom_padding.dart';
import '../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../controllers/home_controller/home_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return customPopScope(
      canPop: false,
      onPopInvoked: (didPop){
        if(didPop) return;
        if(context.read<HomeCubit>().currentIndex != 0){
          context.read<HomeCubit>().changePage(0);
        }
      },
      child: BlocConsumerWidget<HomeCubit, HomeState>(
        listener: (context, state){},
        builder: (context, state){
          return CustomScaffold(
            body: CustomPadding(
              padding: const EdgeInsets.all(8.0),
              child: CustomBuilder(
                builder: (context){
                  return SingleChildScrollView(
                    child: CustomColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AccountSettingsTitleWidget(),
                        CustomSizedBox(height: size.height / 100,),
                        const AccountSettingsBodyWidget(),
                        CustomSizedBox(height: size.height / 50,),
                        const AppSettingsTitle(),
                        CustomSizedBox(height: size.height / 100,),
                        const AppSettingsBodyWidget(),
                        CustomSizedBox(height: size.height / 50,),
                        const LogOutTitleWidget(),
                        CustomSizedBox(height: size.height / 100,),
                        const DeleteAccountWidget(),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
