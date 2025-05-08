import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_builder.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_center.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_pop_scope.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';
import 'package:tylo/tylo/presentation/pages/group_details_page/widgets/group_created_at_widget.dart';
import 'package:tylo/tylo/presentation/pages/group_details_page/widgets/group_image_widget.dart';
import 'package:tylo/tylo/presentation/pages/group_details_page/widgets/group_details_page_app_bar_title_widget.dart';
import 'package:tylo/tylo/presentation/pages/group_details_page/widgets/group_members_title_widget.dart';
import 'package:tylo/tylo/presentation/pages/group_details_page/widgets/group_members_widget.dart';
import 'package:tylo/tylo/presentation/pages/group_details_page/widgets/group_owner_widget.dart';
import '../../../core/components/custom_widgets/custom_app_bar.dart';
import '../../../core/components/custom_widgets/custom_column.dart';
import '../../../core/components/custom_widgets/custom_padding.dart';
import '../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../core/components/custom_widgets/custom_stack.dart';
import '../../../core/helper_functions/navigator/navigator_pop.dart';
import '../../controllers/file_picker_controller/file_picker_cubit.dart';
import '../edit_profile_page/widgets/edit_profile_pick_image_widget.dart';
import '../group_chat_room_page/widgets/group_name_widget.dart';

class GroupDetailsPage extends StatefulWidget {
  const GroupDetailsPage({super.key});

  @override
  State<GroupDetailsPage> createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GroupCubit>(context, listen:  false).getGroupMembers();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return customPopScope(
      onPopInvoked: (didPop){
        if (didPop) {
          return;
        }
        context.read<FilePickerCubit>().nullifyPickedFileData();
        navigateAndPop(context);

      },
      child: CustomScaffold(
          appBar: customAppBar(
            context: context,
            title: const GroupDetailsPageAppBarTitleWidget(),
            onPressed: (){
              context.read<FilePickerCubit>().nullifyPickedFileData();
              navigateAndPop(context);
            },
          ),
          body: CustomPadding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: CustomCenter(
                child: CustomColumn(
                  children: [
                    CustomSizedBox(height: size.height / 25,),
                    const GroupNameWidget(),
                    CustomSizedBox(height: size.height / 50,),
                    CustomStack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        const GroupImageWidget(),
                        CustomBuilder(
                          builder: (context){
                            if(context.read<GroupCubit>().group!.ownerId == context.read<HomeCubit>().id){
                              return const EditProfilePickImageWidget();
                            }
                            return CustomSizedBox();
                          },
                        )
                      ],
                    ),
                    CustomSizedBox(height: size.height / 20,),
                    const GroupCreatedAtWidget(),
                    CustomSizedBox(height: size.height / 20,),
                    const GroupOwnerWidget(),
                    CustomSizedBox(height: size.height / 20,),
                    const GroupMembersTitleWidget(),
                    CustomSizedBox(height: size.height / 50,),
                    const GroupMembersWidget(),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}
