import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_column.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_scaffold.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';
import 'package:tylo/tylo/presentation/pages/add_new_contact_page/widgets/add_new_contact_button_widget.dart';
import 'package:tylo/tylo/presentation/pages/add_new_contact_page/widgets/add_new_contact_firestore_cubit_listener_widget.dart';
import 'package:tylo/tylo/presentation/pages/add_new_contact_page/widgets/add_new_contact_page_app_bar_title_widget.dart';
import 'package:tylo/tylo/presentation/pages/add_new_contact_page/widgets/contact_name_text_field_widget.dart';
import 'package:tylo/tylo/presentation/pages/add_new_contact_page/widgets/contact_name_title_widget.dart';
import 'package:tylo/tylo/presentation/pages/add_new_contact_page/widgets/contact_phone_number_text_field_widget.dart';
import 'package:tylo/tylo/presentation/pages/add_new_contact_page/widgets/contact_phone_number_title_widget.dart';
import '../../../core/components/custom_widgets/custom_app_bar.dart';
import '../../../core/components/custom_widgets/custom_padding.dart';
import '../../../core/helper_functions/check_if_number_contains_country_code.dart';
import '../../../core/helper_functions/navigator/navigator_pop.dart';
import '../../../core/resources/constants/firebase_constants.dart';
import '../../controllers/contacts_controller/contacts_cubit.dart';

class AddNewContactPage extends StatefulWidget {
  const AddNewContactPage({super.key});

  @override
  State<AddNewContactPage> createState() => _AddNewContactPageState();
}

class _AddNewContactPageState extends State<AddNewContactPage> {
  late ContactsCubit _contactsCubit;

  @override
  void initState() {
    super.initState();
    _contactsCubit = BlocProvider.of<ContactsCubit>(context, listen: false);
    _contactsCubit.initAddContactTextEditingController();
  }

  @override
  void dispose() {
    _contactsCubit.disposeAddContactTextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AddNewContactFireStoreCubitListenerWidget(
      child: BlocConsumerWidget<ContactsCubit, ContactsState>(
        listener: (context, state){
          if(state is InsertNewContactSuccessState){
            final number = checkIfNumberContainsCountryCode( context.read<ContactsCubit>().phoneNumberController.text.trim());
            context.read<FireStoreCubit>().checkIfUserExistByField(
              field: FireBaseConstants.phone,
              value: number,
            );
          }
        },
        builder: (context, state){
          return CustomScaffold(
            appBar: customAppBar(
              context: context,
              title: const AddNewContactPageAppBarTitleWidget(),
              onPressed: (){
                navigateAndPop(context);
              },
            ),
            body: CustomPadding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: CustomColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSizedBox(height: size.height / 10,),
                    const ContactNameTitleWidget(),
                    CustomSizedBox(height: size.height / 50,),
                    const ContactNameTextFieldWidget(),
                    CustomSizedBox(height: size.height / 25,),
                    const ContactPhoneNumberTitleWidget(),
                    CustomSizedBox(height: size.height / 50,),
                    const ContactPhoneNumberTextFieldWidget(),
                    CustomSizedBox(height: size.height / 25,),
                    const AddNewContactButtonWidget(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
