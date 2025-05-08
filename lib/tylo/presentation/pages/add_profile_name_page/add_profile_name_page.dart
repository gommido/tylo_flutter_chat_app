import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_app_bar.dart';
import 'package:tylo/tylo/presentation/pages/add_profile_name_page/widgets/profile_name_first_title_widget.dart';
import 'package:tylo/tylo/presentation/pages/add_profile_name_page/widgets/navigation_to_profile_image_button_widget.dart';
import 'package:tylo/tylo/presentation/pages/add_profile_name_page/widgets/profile_name_second_title_widget.dart';
import 'package:tylo/tylo/presentation/pages/add_profile_name_page/widgets/profile_name_text_field_widget.dart';
import '../../../core/components/bloc_consumer_widget.dart';
import '../../../core/components/custom_widgets/custom_column.dart';
import '../../../core/components/custom_widgets/custom_container.dart';
import '../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../core/components/custom_widgets/custom_spacer.dart';
import '../../../core/helper_functions/navigator/push_named_navigator.dart';
import '../../../core/resources/constants/app_routes.dart';
import '../../controllers/auth_controller/auth_cubit.dart';
import '../../controllers/firestore_controller/fire_store_cubit.dart';

class AddProfileNamePage extends StatefulWidget {
  const AddProfileNamePage({super.key});

  @override
  State<AddProfileNamePage> createState() => _AddProfileNamePageState();
}

class _AddProfileNamePageState extends State<AddProfileNamePage> {
  late FireStoreCubit _fireStoreCubit;

  @override
  void initState() {
    super.initState();
    _fireStoreCubit = BlocProvider.of<FireStoreCubit>(context, listen:  false);
    BlocProvider.of<AuthCubit>(context, listen:  false).getCurrentUserId();
  }
  @override
  void dispose() {
    _fireStoreCubit.disposeProfileNameController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumerWidget<FireStoreCubit, FireStoreState>(
      listener: (context, state) {
        if(state is SetProfileNameState){
          pushNamed(route: AppRoutes.pickProfileImagePage, context: context);
        }
      },
      builder: (context, state) {
        return CustomScaffold(
          appBar: customAppBar(
            context: context,
            isLeadingIconShown: false,
          ),
          body: CustomContainer(
            padding: const EdgeInsets.all(8.0),
            child: CustomColumn(
              children: [
                CustomSizedBox(height: size.height / 25,),
                const ProfileNameFirstTitleWidget(),
                CustomSizedBox(height: size.height / 100,),
                const ProfileNameSecondTitleWidget(),
                CustomSizedBox(height: size.height / 20,),
                const ProfileNameTextFieldWidget(),
                const CustomSpacer(),
                const NavigationToProfileImageButtonWidget(),
                CustomSizedBox(height: size.height / 20,),

              ],
            ),
          ),
        );
      },
    );
  }
}

