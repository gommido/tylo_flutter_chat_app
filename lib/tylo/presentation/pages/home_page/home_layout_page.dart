import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_builder.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_pop_scope.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_stack.dart';
import 'package:tylo/tylo/presentation/controllers/chat_controller/chat_cubit.dart';
import 'package:tylo/tylo/presentation/pages/home_page/widgets/bottom_navigation_bar_widget.dart';
import 'package:tylo/tylo/presentation/pages/home_page/widgets/home_page_call_cubit_listener_widget.dart';
import 'package:tylo/tylo/presentation/pages/home_page/widgets/home_page_contacts_cubit_listener_widget.dart';
import 'package:tylo/tylo/presentation/pages/home_page/widgets/home_page_home_cubit_listener_widget.dart';
import 'package:tylo/tylo/presentation/pages/home_page/widgets/home_page_delete_items_widget.dart';
import 'package:tylo/tylo/presentation/pages/home_page/widgets/home_page_search_widget.dart';
import 'package:tylo/tylo/presentation/pages/home_page/widgets/home_page_text_field_search_widget.dart';
import '../../../core/components/custom_widgets/custom_app_bar.dart';
import '../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/constants/firebase_constants.dart';
import '../../controllers/firestore_controller/fire_store_cubit.dart';
import '../../controllers/home_controller/home_cubit.dart';
import '../calls_home_page/widgets/calls_home_page_pop_menu_widget.dart';
import '../chat_home_page/widgets/chat_home_pop_menu_widget.dart';

class HomeLayoutPage extends StatefulWidget {
  const HomeLayoutPage({super.key,});

  @override
  State<HomeLayoutPage> createState() => _HomeLayoutPageState();
}

class _HomeLayoutPageState extends State<HomeLayoutPage>  with WidgetsBindingObserver {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    BlocProvider.of<HomeCubit>(context, listen: false).getCurrentUserId();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      BlocProvider.of<FireStoreCubit>(context, listen: false).updateAppUserData(
        id: BlocProvider.of<HomeCubit>(context, listen: false).id,
        field: FireBaseConstants.lastSeen,
        value: null,
      );
    }else{
      BlocProvider.of<FireStoreCubit>(context, listen: false).updateAppUserData(
        id: BlocProvider.of<HomeCubit>(context, listen: false).id,
        field: FireBaseConstants.lastSeen,
        value: Timestamp.now(),
      );
    }
    super.didChangeAppLifecycleState(state);
  }


  @override
  Widget build(BuildContext context) {
    return HomePageCallCubitListenerWidget(
      child: HomePageContactsCubitListenerWidget(
        child: HomePageHomeCubitListenerWidget(
          child: customPopScope(
            onPopInvoked: (didPop){
              if (didPop) {
                return;
              }
              if(context.read<HomeCubit>().isLongPressed != null){
                context.read<HomeCubit>().pressDeleteLongPress();
                context.read<ChatCubit>().clearSelectedItems();
              }
              if(context.read<HomeCubit>().isSearchBarTapped != null){
                context.read<HomeCubit>().tapToSearch();
              }
            },
            child: CustomScaffold(
              appBar: customAppBar(
                  backgroundColor: context.watch<HomeCubit>().isSearchBarTapped != null ?
                  ColorManager.primaryColor.withOpacity(0.5) : Theme.of(context).appBarTheme.backgroundColor,
                  context: context,
                  centerTitle: false,
                  isLeadingIconShown: false,
                  title: CustomBuilder(
                    builder: (context){
                      if(context.read<HomeCubit>().isSearchBarTapped != null){
                        return const HomePageTextFieldSearchWidget();
                      }else if(context.read<HomeCubit>().isLongPressed != null){
                        return const HomePageDeleteItemsWidget();
                      }
                      return const HomePageSearchWidget();
                    },
                  ),
                  actions: [
                    CustomBuilder(
                      builder: (context){
                        if(context.watch<HomeCubit>().isSearchBarTapped == null){
                          if(context.watch<ChatCubit>().selectedItems.isEmpty){
                            if(context.read<HomeCubit>().currentIndex == 0){
                              return  const ChatHomePopMenuWidget();
                            }else if(context.read<HomeCubit>().currentIndex == 1){
                              return const CallsHomePagePopMenuWidget();
                            }
                          }
                        }
                        return CustomSizedBox();
                      },
                    )
                  ]
              ),
              backgroundColor: ColorManager.black,
              body: CustomStack(
                children: [
                  context.read<HomeCubit>().pages[context.read<HomeCubit>().currentIndex],
                ],
              ),
              bottomNavigationBar: const BottomNavigationBarWidget(),
            ),
          ),
        ),
      ),
    );

  }
}
