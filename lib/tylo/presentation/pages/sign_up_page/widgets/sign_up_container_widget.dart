import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_container.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_expanded.dart';
import 'package:tylo/tylo/presentation/controllers/auth_controller/auth_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/helper_functions/navigator/push_named_remove_until.dart';
import '../../../../core/resources/constants/app_routes.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/services/shared_preference/shared_prefs_manager.dart';

class SignUpContainerWidget extends StatelessWidget {
  const SignUpContainerWidget({super.key, required this.icon, required this.isGoogleLogin,});
  final IconData icon;
  final bool isGoogleLogin;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumerWidget<AuthCubit, AuthState>(
      listener: (context, state){},
      builder: (context, state){
        return BlocConsumerWidget<FireStoreCubit, FireStoreState>(
          listener: (context, state){
            if(state is CheckIfUserExistByFieldSuccessState
                && context.read<FireStoreCubit>().existUser != null){
              SharedPrefsManager.saveStringData(
                key: 'id',
                value: context.read<FireStoreCubit>().existUser!.id,
              ).then((value){
                context.read<AuthCubit>().close();
                pushNamedRemoveUntil(route: AppRoutes.homeLayoutPage, context: context);
              });

            }
          },
          builder: (context, state){
            return BlocConsumerWidget<AuthCubit, AuthState>(
              listener: (context, state){
              },
              builder: (context, state){
                return CustomExpanded(
                  child: GestureDetector(
                    onTap: (){

                    },
                    child: CustomContainer(
                      margin: const EdgeInsets.all(5.0),
                      alignment: AlignmentDirectional.center,
                      height: size.height / 15,
                      width: size.width / 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ColorManager.white,
                      ),
                      child: CustomIcon(icon: icon, color: ColorManager.blue,),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );

  }
}
