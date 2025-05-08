import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_list_view_widget.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_scaffold.dart';
import 'package:tylo/tylo/presentation/pages/block_list_page/widgets/block_list_app_bar_title_widget.dart';
import 'package:tylo/tylo/presentation/pages/block_list_page/widgets/blocked_contact_title_widget.dart';
import 'package:tylo/tylo/presentation/pages/block_list_page/widgets/remove_blocked_contact_widget.dart';
import '../../../core/components/bloc_consumer_widget.dart';
import '../../../core/components/custom_cached_network_image_widget.dart';
import '../../../core/components/custom_circle_shape_widget.dart';
import '../../../core/components/custom_widgets/custom_app_bar.dart';
import '../../../core/components/custom_widgets/custom_builder.dart';
import '../../../core/components/custom_widgets/custom_icon.dart';
import '../../../core/components/custom_widgets/custom_padding.dart';
import '../../../core/components/custom_widgets/custom_row.dart';
import '../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../core/components/custom_widgets/custom_spacer.dart';
import '../../../core/helper_functions/navigator/navigator_pop.dart';
import '../../../core/resources/color_manager.dart';
import '../../controllers/local_storage_controller/local_storage_cubit.dart';
import 'widgets/block_list_empty_widget.dart';

class BlockListPage extends StatelessWidget {
  const BlockListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(
        context: context,
        title: const BlockListAppBarTitleWidget(),
        onPressed: (){
          navigateAndPop(context);
        },
      ),
      body: BlocConsumerWidget<LocalStorageCubit, LocalStorageState>(
        listener: (context, state){},
        builder: (context, state){
          final size = MediaQuery.of(context).size;
          final blockedContacts = context.read<LocalStorageCubit>().getBlockedContactsFromLocalStorage();
          if(blockedContacts.isEmpty){
            return const BlockListEmptyWidget();
          }
          return CustomPadding(
            padding: const EdgeInsets.all(8.0),
            child: CustomListViewWidget(
              itemCount: blockedContacts.length,
              separatorBuilder: (context, index) => CustomSizedBox(),
              itemBuilder: (context, index){
                return CustomRow(
                  children: [
                    CustomCircleShapeWidget(
                        width: size.width / 8,
                        height: size.width / 8,
                        image: CustomBuilder(
                          builder: (context){
                            if(blockedContacts[index].image.isNotEmpty){
                              return ClipOval(
                                child: CustomCachedNetworkImageWidget(
                                  width: size.width / 10,
                                  height: size.width / 10,
                                  imageUrl: blockedContacts[index].image,
                                  icon: Icons.person,
                                ),
                              );
                            }
                            return CustomIcon(icon: Icons.person, color: ColorManager.grey,);
                          },
                        )
                    ),

                    CustomSizedBox(width: size.width / 50,),
                    BlockedContactTitleWidget(
                      contact: blockedContacts[index],
                    ),
                    const CustomSpacer(),
                    RemoveBlockedContactWidget(
                      blockedContacts: blockedContacts,
                      index: index,
                    ),
                    CustomSizedBox(width: size.width / 50,),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}