import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_app_bar.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/secure_local_storage/secure_local_storage.dart';
import 'package:tylo/tylo/presentation/pages/otp_verification_page/widgets/getting_message_title_widget.dart';
import 'package:tylo/tylo/presentation/pages/otp_verification_page/widgets/phone_verification_title_widget.dart';
import 'package:tylo/tylo/presentation/pages/otp_verification_page/widgets/resend_text_widget.dart';
import 'package:tylo/tylo/presentation/pages/otp_verification_page/widgets/navigation_to_profile_name_button_widget.dart';
import 'package:tylo/tylo/presentation/pages/otp_verification_page/widgets/pin_put_widget.dart';
import '../../../core/components/bloc_consumer_widget.dart';
import '../../../core/components/custom_widgets/custom_column.dart';
import '../../../core/components/custom_widgets/custom_modal_progress_hud.dart';
import '../../../core/components/custom_widgets/custom_padding.dart';
import '../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../core/components/custom_widgets/custom_snack_bar.dart';
import '../../../core/components/custom_widgets/custom_spacer.dart';
import '../../../core/helper_functions/navigator/navigator_pop.dart';
import '../../../core/helper_functions/navigator/push_named_remove_until.dart';
import '../../../core/resources/constants/app_routes.dart';
import '../../../core/resources/constants/firebase_constants.dart';
import '../../../core/services/shared_preference/shared_prefs_manager.dart';
import '../../controllers/auth_controller/auth_cubit.dart';
import '../../controllers/firestore_controller/fire_store_cubit.dart';


class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  late AuthCubit _fireBaseAuthCubit;

  @override
  void initState() {
    super.initState();
    _fireBaseAuthCubit = BlocProvider.of<AuthCubit>(context, listen: false);
    _fireBaseAuthCubit.startPinCodeTimer();
  }

  @override
  void dispose() {
    _fireBaseAuthCubit.disposeTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<FireStoreCubit, FireStoreState>(
      listener: (context, state){
        if(state is CheckIfUserExistByFieldSuccessState && context.read<FireStoreCubit>().existUser != null){
          SecureLocalStorage.write(key: AppStrings.id, value: context.read<FireStoreCubit>().existUser!.id).then((value){
            SharedPrefsManager.saveBoolData(key: AppStrings.isCreated, value: true).then((value){
              pushNamedRemoveUntil(route: AppRoutes.homeLayoutPage, context: context);
            });
          });

        }
        if(state is CheckIfUserExistByFieldSuccessState && context.read<FireStoreCubit>().existUser == null){
          pushNamedRemoveUntil(route: AppRoutes.addProfileNamePage, context: context);
        }

      },
      builder: (context, state){
        return BlocConsumerWidget<AuthCubit, AuthState>(
          listener: (context, state){
            if(state is VerifyPhoneNumberSuccessState){
              final number = context.read<AuthCubit>().phoneNumber.replaceAll(AppStrings.plus, AppStrings.twoZeros);
              context.read<FireStoreCubit>().checkIfUserExistByField(
                field: FireBaseConstants.phone,
                value: number,
              );
            }
            if(state is VerifyPhoneNumberFailureState){
              CustomToast.show(title: state.error,);
            }
          },
          builder: (context, state){
            final size = MediaQuery.of(context).size;
            return CustomModalProgressHUD(
              inAsyncCall: state is VerifyPhoneNumberLoadingState || state is CheckIfUserExistByFieldLoadingState,
              child: CustomScaffold(
                appBar: customAppBar(
                  context: context,
                  onPressed: (){
                    navigateAndPop(context);
                  },
                ),
                body: CustomPadding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomColumn(
                    children: [
                      CustomSizedBox(height: size.height / 25,),
                      const PhoneVerificationTitleWidget(),
                      CustomSizedBox(height: size.height / 100,),
                      const GettingMessageTitleWidget(),
                      CustomSizedBox(height: size.height / 20,),
                      PinPutWidget(
                        onTapOutside: (event){
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        onChanged: (String pin){
                          _fireBaseAuthCubit.setPinCode(pin);
                        },
                      ),
                      const ResendTextWidget(),
                      const CustomSpacer(),
                      const NavigationToProfileNameButtonWidget(),
                      CustomSizedBox(height: size.height / 20,),

                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );

  }
}
