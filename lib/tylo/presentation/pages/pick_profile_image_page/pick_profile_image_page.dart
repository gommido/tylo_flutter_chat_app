import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_snack_bar.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';
import 'package:tylo/tylo/core/services/shared_preference/shared_prefs_manager.dart';
import 'package:tylo/tylo/presentation/controllers/auth_controller/auth_cubit.dart';
import 'package:tylo/tylo/presentation/pages/pick_profile_image_page/widgets/create_account_button_widget.dart';
import 'package:tylo/tylo/presentation/pages/pick_profile_image_page/widgets/picking_profile_image_widget.dart';
import 'package:tylo/tylo/presentation/pages/pick_profile_image_page/widgets/profile_image_first_title_widget.dart';
import 'package:tylo/tylo/presentation/pages/pick_profile_image_page/widgets/profile_image_second_title_widget.dart';
import '../../../core/components/bloc_consumer_widget.dart';
import '../../../core/components/custom_widgets/custom_app_bar.dart';
import '../../../core/components/custom_widgets/custom_column.dart';
import '../../../core/components/custom_widgets/custom_container.dart';
import '../../../core/components/custom_widgets/custom_modal_progress_hud.dart';
import '../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../core/components/custom_widgets/custom_spacer.dart';
import '../../../core/components/custom_widgets/custom_stack.dart';
import '../../../core/helper_functions/navigator/navigator_pop.dart';
import '../../../core/helper_functions/navigator/push_named_remove_until.dart';
import '../../../core/resources/constants/app_routes.dart';
import '../../controllers/firestore_controller/fire_store_cubit.dart';

class PickProfileImagePage extends StatefulWidget {
  const PickProfileImagePage({super.key});

  @override
  State<PickProfileImagePage> createState() => _PickProfileImagePageState();
}

class _PickProfileImagePageState extends State<PickProfileImagePage> {
  late AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = BlocProvider.of<AuthCubit>(context, listen: false);
  }

  @override
  void dispose() {
    _authCubit.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumerWidget<FireStoreCubit, FireStoreState>(
      listener: (context, state) {
        if (state is CreateAppUserSuccessState) {
          SharedPrefsManager.saveBoolData(key: AppStrings.isCreated, value: true).then((value){
            pushNamedRemoveUntil(route: AppRoutes.homeLayoutPage, context: context);
            context.read<AuthCubit>().close();
            CustomToast.show(title: translate(context, AppStrings.accountCreated));
          });
        }
        if (state is CreateAppUserFailureState) {
          CustomToast.show(title: state.error,);
        }
      },
      builder: (context, state) {
        return CustomModalProgressHUD(
          inAsyncCall: state is CreateAppUserLoadingState,
          child: CustomScaffold(
              appBar: customAppBar(
                context: context,
                onPressed: (){
                    navigateAndPop(context);
                  },
              ),
              body: CustomStack(
                alignment: Alignment.center,
                children: [
                  CustomContainer(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomColumn(
                      children: [
                        CustomSizedBox(height: size.height / 25,),
                        const ProfileImageFirstTitleWidget(),
                        CustomSizedBox(height: size.height / 100,),
                        const ProfileImageSecondTitleWidget(),
                        CustomSizedBox(height: size.height / 10,),
                        const PickingProfileImageWidget(),
                        CustomSizedBox(height: size.height / 25,),
                        const CustomSpacer(),
                        const CreateAccountButtonWidget(),
                        CustomSizedBox(height: size.height / 20,),
                      ],
                    ),
                  ),
                ],
              ),
            ),

        );
      },
    );
  }
}
