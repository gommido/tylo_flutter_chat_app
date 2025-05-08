import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_list_view_widget.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/presentation/controllers/local_storage_controller/local_storage_cubit.dart';
import 'package:tylo/tylo/presentation/pages/not_registered_contacts_page/widgets/selected_contact_icon_widget.dart';
import 'package:tylo/tylo/presentation/pages/not_registered_contacts_page/widgets/share_app_widget.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_expanded.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_padding.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/services/localization/localization.dart';
import '../../../controllers/contacts_controller/contacts_cubit.dart';
import '../../registered_contacts_page/widgets/contact_card_widget.dart';
import '../../registered_contacts_page/widgets/contacts_body_widget.dart';


class NotRegisteredContactsWidget extends StatelessWidget {
  const NotRegisteredContactsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumerWidget<LocalStorageCubit, LocalStorageState>(
        listener: (context, state) {},
        builder: (context, state) {
         if(context.read<LocalStorageCubit>().storedNotRegisteredContacts.isNotEmpty){
           return ContactsBodyWidget(
             title: translate(context, AppStrings.invite),
             contactsNumber: context.read<LocalStorageCubit>().storedNotRegisteredContacts.length.toString(),
             widget: CustomPadding(
               padding: const EdgeInsets.all(10.0),
               child: CustomListViewWidget(
                   separatorBuilder: (context, index)=> CustomSizedBox(height: size.height / 100,),
                   shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),
                   itemCount: context.read<LocalStorageCubit>().storedNotRegisteredContacts.length,
                   itemBuilder: (context, index) {
                     return BlocConsumerWidget<ContactsCubit, ContactsState>(
                         listener: (context, state){},
                         builder: (context, state){
                           return CustomGestureDetector(
                             onTap: (){
                               if(index == 0){
                                 context.read<ContactsCubit>().shareApp(
                                   invitation: '${translate(context, AppStrings.iAmUsingTylo)}: ${AppStrings.playStoreLink}${AppStrings.packageName}',
                                 );
                               }else{
                                 if(context.read<ContactsCubit>().selectedContact == null){
                                   context.read<ContactsCubit>().selectContactToShare(index);
                                 }else{
                                   if(context.read<ContactsCubit>().selectedContact! == index){
                                     context.read<ContactsCubit>().initSelectedContact();
                                   }else{
                                     context.read<ContactsCubit>().selectContactToShare(index);
                                   }
                                 }
                               }
                             },
                             child: CustomContainer(
                                 padding: const EdgeInsets.all(4.0),
                                 width: size.width,
                                 decoration: BoxDecoration(
                                   color: context.read<ContactsCubit>().selectedContact != null && context.read<ContactsCubit>().selectedContact! == index ?
                                   ColorManager.primaryColor.withOpacity(0.1) : Colors.transparent,
                                 ),
                                 child: CustomBuilder(
                                   builder: (context){
                                     if(index == 0){
                                       return const ShareAppWidget();
                                     }
                                     return CustomRow(
                                       children: [
                                         CustomExpanded(
                                           child: ContactCardWidget(
                                             contact: context.read<LocalStorageCubit>().storedNotRegisteredContacts[index],
                                             isRegistered: false,
                                           ),
                                         ),
                                         SelectedContactIconWidget(index: index,),
                                         CustomSizedBox(width: size.width / 25,),
                                       ],
                                     );
                                   },
                                 )
                             ),
                           );
                         },
                     );
                   }
               ),
             ),
           );
         }
         return const SizedBox();
  },
);
  }
}


