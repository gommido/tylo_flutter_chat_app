import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_builder.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_column.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/presentation/pages/registered_contacts_page/widgets/get_contacts_permission_widget.dart';
import 'package:tylo/tylo/presentation/pages/registered_contacts_page/widgets/invite_friends_widget.dart';
import 'package:tylo/tylo/presentation/pages/registered_contacts_page/widgets/registered_contacts_app_bar_title_widget.dart';
import 'package:tylo/tylo/presentation/pages/registered_contacts_page/widgets/registered_contacts_widget.dart';
import '../../../core/components/bloc_consumer_widget.dart';
import '../../../core/components/custom_widgets/custom_app_bar.dart';
import '../../../core/components/custom_widgets/custom_padding.dart';
import '../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../core/helper_functions/navigator/navigator_pop.dart';
import '../../controllers/contacts_controller/contacts_cubit.dart';
import '../../controllers/home_controller/home_cubit.dart';

class RegisteredContactsPage extends StatelessWidget {
  const RegisteredContactsPage({super.key,});


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(
        context: context,
        title: const RegisteredContactsAppBarTitleWidget(),
        onPressed: (){
          navigateAndPop(context);
        },
      ),
      body: BlocConsumerWidget<ContactsCubit, ContactsState>(
        listener: (context, state){},
        builder: (context, state){
          if(context.read<ContactsCubit>().permissionStatus != PermissionStatus.granted &&
              context.read<ContactsCubit>().permissionStatus != PermissionStatus.permanentlyDenied){
            return const GetContactsPermissionWidget();
          }
          return CustomPadding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: CustomColumn(
                children: [
                  CustomBuilder(
                    builder: (context){
                      if(context.read<HomeCubit>().pageType! == AppStrings.chat){
                        return const InviteFriendsWidget();
                      }
                      return CustomSizedBox();
                    },
                  ),
                  const RegisteredContactsWidget(),
                ],
              ),
            ),
          );

        },
      )
    );
  }
}
