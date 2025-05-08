import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';

import '../../../../core/components/custom_alert_dialog_widget.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_icon_button.dart';
import '../../../../core/components/custom_widgets/custom_snack_bar.dart';
import '../../../../core/helper_functions/navigator/navigator_pop.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../domain/entities/app_contact.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';
import '../../../controllers/local_storage_controller/local_storage_cubit.dart';

class RemoveBlockedContactWidget extends StatelessWidget {
  const RemoveBlockedContactWidget({super.key, required this.blockedContacts, required this.index});
  final List<AppContact> blockedContacts;
  final int index;

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: (){
        showDialog(
            context: context,
            builder: (context){
              return CustomAlertDialogWidget(
                title: translate(context, AppStrings.removeThisContactFRomBlockList),
                onPressed: (){
                  navigateAndPop(context);
                  if(blockedContacts.isNotEmpty){
                    final contact = blockedContacts[index];
                    blockedContacts.removeWhere((contact)=> contact.id == contact.id);
                    context.read<LocalStorageCubit>().saveBlockedContactsToLocalStorage(contacts: blockedContacts).then((onValue){
                      context.read<LocalStorageCubit>().getBlockedContactsFromLocalStorage();
                    });
                    context.read<FireStoreCubit>().blockContact(blockedId: contact.id, isBlocking: false,);
                    CustomToast.show(title: '${contact.phone} ${translate(context, AppStrings.removedFromBlockList)}');
                  }
                },
              );

            },
        );

      },
      icon: CustomIcon(
        icon: Icons.remove_circle_outline,
        color: ColorManager.red,
      ),
    );
  }
}
