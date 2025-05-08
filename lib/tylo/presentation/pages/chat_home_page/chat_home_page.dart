import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_builder.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import 'package:tylo/tylo/presentation/controllers/chat_controller/chat_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';
import 'package:tylo/tylo/presentation/pages/chat_home_page/widgets/searched_contacts_widget.dart';
import '../../../core/components/bloc_consumer_widget.dart';
import '../../../core/components/custom_widgets/custom_list_view_widget.dart';
import '../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../core/components/home_page_no_items_widget.dart';
import '../../../core/helper_functions/navigator/push_named_navigator.dart';
import '../../../core/resources/constants/app_routes.dart';
import '../../../core/resources/constants/app_strings.dart';
import '../../../core/services/localization/localization.dart';
import '../chat_room_page/widgets/last_message_widget.dart';
import '../../../core/components/custom_widgets/custom_floating_action_button_widget.dart';

class ChatHomePage extends StatelessWidget {
  const ChatHomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumerWidget<ChatCubit, ChatState>(
        listener: (context, state){},
        builder: (context, state){
          final size = MediaQuery.of(context).size;
          return CustomScaffold(
            body: CustomBuilder(
              builder: (context){
                if(context.watch<HomeCubit>().isSearchBarTapped == null){
                  if(context.read<ChatCubit>().lastMessages.isEmpty){
                    return HomePageNoItemsWidget(
                      title: translate(context, AppStrings.noMessagesYet),
                      icon: Icons.chat_bubble_outline,
                    );
                  }
                  return CustomListViewWidget(
                    itemCount: context.read<ChatCubit>().lastMessages.length,
                    itemBuilder: (context, index){
                      final lastMessage = context.read<ChatCubit>().lastMessages[index];
                      return LastMessageWidget(lastMessage: lastMessage,);

                    },
                    separatorBuilder: (context, index) => CustomSizedBox(height: size.height / 200,),
                  );
                }
                return const SearchedContactsWidget();
              },
            ),
            floatingActionButton: CustomFloatingActionButtonWidget(
              onPressed: (){
                context.read<HomeCubit>().getPageTypeWhenNavigate(AppStrings.chat);
                pushNamed(context: context, route: AppRoutes.registeredContactsPage);
                if(context.read<HomeCubit>().isLongPressed != null){
                  context.read<HomeCubit>().pressDeleteLongPress();
                  context.read<ChatCubit>().clearSelectedItems();
                }
              },
              icon: Ionicons.chatbubble,
            ),
          );
        },
      );
  }
}