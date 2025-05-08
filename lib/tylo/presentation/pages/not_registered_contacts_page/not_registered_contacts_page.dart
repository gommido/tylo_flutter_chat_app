import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_app_bar.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_scaffold.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_stack.dart';
import 'package:tylo/tylo/core/helper_functions/navigator/navigator_pop.dart';
import 'package:tylo/tylo/presentation/pages/not_registered_contacts_page/widgets/bottom_send_invitation_widget.dart';
import 'package:tylo/tylo/presentation/pages/not_registered_contacts_page/widgets/not_registered_contacts_app_bar_title_widget.dart';
import 'package:tylo/tylo/presentation/pages/not_registered_contacts_page/widgets/select_contacts_text_widget.dart';
import '../../../core/components/custom_widgets/custom_column.dart';
import '../../controllers/contacts_controller/contacts_cubit.dart';
import 'widgets/not_registered_contacts_widget.dart';

class NotRegisteredContactsPage extends StatefulWidget {
  const NotRegisteredContactsPage({super.key});

  @override
  State<NotRegisteredContactsPage> createState() => _NotRegisteredContactsPageState();
}

class _NotRegisteredContactsPageState extends State<NotRegisteredContactsPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ContactsCubit>(context, listen: false).initSelectedContact();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(
        context: context,
        title: const NotRegisteredContactsAppBarTitleWidget(),
        onPressed: ()=> navigateAndPop(context),
      ),
      body: CustomStack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: CustomColumn(
              children: const [
                SelectContactsTextWidget(),
                NotRegisteredContactsWidget(),
              ],
            ),
          ),
          const BottomSendInvitationWidget(),
        ],
      ),
    );
  }
}
