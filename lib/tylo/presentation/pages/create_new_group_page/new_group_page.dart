import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_app_bar.dart';
import 'package:tylo/tylo/core/helper_functions/navigator/push_named_and_replace.dart';
import 'package:tylo/tylo/core/resources/constants/app_routes.dart';
import 'package:tylo/tylo/presentation/controllers/file_picker_controller/file_picker_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';
import 'package:tylo/tylo/presentation/pages/create_new_group_page/widgets/create_group_button_widget.dart';
import 'package:tylo/tylo/presentation/pages/create_new_group_page/widgets/group_name_text_field_widget.dart';
import 'package:tylo/tylo/presentation/pages/create_new_group_page/widgets/new_group_page_app_bar_title_widget.dart';
import 'package:tylo/tylo/presentation/pages/create_new_group_page/widgets/pick_contacts_list_widget.dart';
import 'package:tylo/tylo/presentation/pages/create_new_group_page/widgets/picked_contacts_count_widget.dart';
import '../../../core/components/bloc_consumer_widget.dart';
import '../../../core/components/custom_widgets/custom_column.dart';
import '../../../core/components/custom_widgets/custom_modal_progress_hud.dart';
import '../../../core/components/custom_widgets/custom_padding.dart';
import '../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../core/helper_functions/navigator/navigator_pop.dart';
import '../group_chat_room_page/widgets/picked_group_image_widget.dart';

class NewGroupPage extends StatefulWidget {
  const NewGroupPage({super.key});

  @override
  State<NewGroupPage> createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  late GroupCubit _groupCubit;

  @override
  void initState() {
    super.initState();
    _groupCubit = BlocProvider.of<GroupCubit>(context, listen: false);
    _groupCubit.initNameController();
    _groupCubit.clearSelectedUsers();
    BlocProvider.of<FilePickerCubit>(context, listen: false).nullifyPickedFileData();
  }

  @override
  void dispose() {
    _groupCubit.disposeNameController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<GroupCubit, GroupState>(
      listener: (context, state){
        if(state is CreateGroupSuccessState){
          pushNamedAndReplace(route: AppRoutes.groupChatRoomPage, context: context, arguments: context.read<GroupCubit>().newGroupCreatedId);
        }
      },
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        return CustomModalProgressHUD(
          inAsyncCall: state is CreateGroupLoadingsState,
          child: CustomScaffold(
            appBar: customAppBar(
              context: context,
              title: const NewGroupPageAppBarTitleWidget(),
              onPressed: (){
                navigateAndPop(context);
              },
              actions: context.watch<GroupCubit>().selectedContacts.isNotEmpty ?
              [
                const PickedContactsCountWidget(),
              ] : null,
            ),
            body: CustomPadding(
              padding: const EdgeInsets.all(8.0),
              child:  CustomColumn(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const PickedGroupImageWidget(),
                  CustomSizedBox(height: size.height / 100,),
                  const GroupNameTextFieldWidget(),
                  CustomSizedBox(height: size.height / 100,),
                  const PickContactsListWidget(),
                  CustomSizedBox(height: size.height / 100,),
                  const CreateGroupButtonWidget(),
                  CustomSizedBox(height: size.height / 100,),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
