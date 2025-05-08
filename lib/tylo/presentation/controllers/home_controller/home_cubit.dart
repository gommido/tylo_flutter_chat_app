import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:meta/meta.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_builder.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_circle_avatar.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_stack.dart';
import 'package:tylo/tylo/core/resources/color_manager.dart';
import 'package:tylo/tylo/core/resources/font_manager.dart';
import 'package:tylo/tylo/core/services/secure_local_storage/secure_local_storage.dart';
import 'package:tylo/tylo/domain/entities/app_contact.dart';
import 'package:tylo/tylo/presentation/pages/chat_home_page/chat_home_page.dart';
import 'package:tylo/tylo/presentation/pages/groups_home_page/groups_home_page.dart';
import '../../../core/components/custom_widgets/custom_container.dart';
import '../../../core/components/custom_widgets/custom_icon.dart';
import '../../../core/components/custom_widgets/custom_padding.dart';
import '../../../core/components/custom_widgets/custom_text.dart';
import '../../pages/calls_home_page/calls_home_page.dart';
import '../../pages/settings_page/settings_page.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()){
    _navigatorKey =  GlobalKey<NavigatorState>();
    _id = '';
  }

  late GlobalKey<NavigatorState> _navigatorKey;
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  late String _id;
  String get id => _id;
  Future<String> getCurrentUserId()async{
    await SecureLocalStorage.read(key: 'id').then((id){
      if(id != null){
        _id = id;
        emit(GetCurrentUserIdState());
      }
    });
    return _id;
  }

  // Home Layout Pages
  final List<Widget> _pages = [
    const ChatHomePage(),
    const CallsHomePage(),
    const GroupsHomePage(),
    const SettingsPage(),
  ];

  List<Widget> get pages => _pages;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  // Chane Page
  void changePage(int index){
    _currentIndex = index;
    emit(InitCurrentIndexState());
  }

  void setCurrentIndexData(){
    _currentIndex = 0;
  }

  // Get Taps
  List<BottomNavigationBarItem> getTabs({required BuildContext context, int? count,}) {
    return [
      BottomNavigationBarItem(
        icon: CustomStack(
          children: [
            CustomContainer(
              margin: const EdgeInsets.all(5),
              width: 50,
              height: 30,
              decoration: BoxDecoration(
                color: _currentIndex == 0 ? ColorManager.primaryColor.withOpacity(0.2) : null,
                  borderRadius: BorderRadius.circular(15),
                border: _currentIndex == 0 ?  null : Border.all(color: ColorManager.grey.withOpacity(0.1),),
              ),
              child: CustomIcon(
                icon: Ionicons.home,
                size: 20,
              ),
            ),
            CustomBuilder(
              builder: (context){
                if(count != null && count != 0){
                  return CustomCircleAvatar(
                    radius: 8,
                    backgroundColor: ColorManager.green,
                    child: CustomText(
                      data: count.toString(),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: FontManager.s08
                      ),
                    ),
                  );
                }
                return CustomSizedBox();
              },
            )
          ],
        ),
        label: 'chats',
      ),
      BottomNavigationBarItem(
        icon: CustomContainer(
          margin: const EdgeInsets.all(5),
          width: 50,
          height: 30,
          decoration:  BoxDecoration(
            color: _currentIndex == 1 ? ColorManager.primaryColor.withOpacity(0.2) : null,
            borderRadius: BorderRadius.circular(15),
            border: _currentIndex == 1 ?  null : Border.all(color: ColorManager.grey.withOpacity(0.1),),

          ),
          child: CustomIcon(
            icon: Ionicons.call,
            size: 20,
          ),
        ),
        label: 'calls',
      ),
      BottomNavigationBarItem(
        icon: CustomContainer(
          margin: const EdgeInsets.all(5),
          width: 50,
          height: 30,
          decoration: BoxDecoration(
            color: _currentIndex == 2 ? ColorManager.primaryColor.withOpacity(0.2) : null,
            borderRadius: BorderRadius.circular(15),
            border: _currentIndex == 2 ?  null : Border.all(color: ColorManager.grey.withOpacity(0.1),),

          ),
          child: CustomIcon(
            icon: Ionicons.people,
            size: 20,
          ),
        ),
        label: 'groups',
      ),
      BottomNavigationBarItem(
        icon: CustomContainer(
          margin: const EdgeInsets.all(5),
          width: 50,
          height: 30,
          decoration: BoxDecoration(
            color: _currentIndex == 3 ? ColorManager.primaryColor.withOpacity(0.2) : null,
            borderRadius: BorderRadius.circular(15),
            border: _currentIndex == 3 ?  null : Border.all(color: ColorManager.grey.withOpacity(0.1),),

          ),
          child: CustomIcon(
            icon: Ionicons.settings,
            size: 20,
          ),
        ),
        label: 'settings',
      ),

    ];
  }

  // chat pages tabs
  final List<Widget> _tabs =[
    CustomPadding(
      padding: const EdgeInsets.all(8.0),
      child: CustomIcon(
        icon: Icons.message_outlined,
      ),
    ),
    CustomPadding(
      padding: const EdgeInsets.all(8.0),
      child: CustomIcon(
        icon: Icons.call_sharp,
      ),
    ),
    CustomPadding(
      padding: const EdgeInsets.all(8.0),
      child: CustomIcon(
        icon: Icons.group,
      ),
    ),
  ];

  get tabs => _tabs;

  // chat pages tab bar view
  final List<Widget> _tabBarView =[
    const ChatHomePage(),
    const CallsHomePage(),
    const GroupsHomePage(),
  ];
  get tabBarView => _tabBarView;

  int currentTabIndex = 0;
  void getCurrentTabIndex(int index){
    currentTabIndex = index;
    emit(GetCurrentTabIndexState());
  }

  bool? _isSearchBarTapped;
  bool? get isSearchBarTapped => _isSearchBarTapped;

  void tapToSearch({bool? isTapped}){
    _isSearchBarTapped = isTapped;
    emit(TapToSearchState());
  }

  late List<AppContact> _searchedList;
  List<AppContact> get searchedList => _searchedList;

  void initSearchedList(){
    _searchedList = [];
  }

  List<AppContact> searchForContacts({required List<AppContact> contacts, required String searchedContact}){
    _searchedList = [];
    _searchedList = contacts.where((contact) => contact.name.toLowerCase().startsWith(searchedContact.toLowerCase())).toList();
    emit(SearchForContactsState());
    return _searchedList;
  }

  void clearSearchedList(){
    _searchedList.clear();
  }

  bool? _isLongPressed;
  bool? get isLongPressed => _isLongPressed;

  void pressDeleteLongPress({bool? isLongPressed,}){
    _isLongPressed = isLongPressed;
    emit(PressDeleteLongPressState());
  }


  String? _currentLanguage;
  String? get currentLanguage => _currentLanguage;
  void onChangeAppLanguage(String language){
    _currentLanguage = language;
    emit(ChangeAppLanguageState());
  }


  Future<void> onLogOutLoading() async{
    emit(LogOutLoadingLoadingState());
    await Future.delayed(const Duration(seconds: 3));
      emit(LogOutLoadingSuccessState());
  }

  String? _pageType;
  String? get pageType => _pageType;
  String getPageTypeWhenNavigate(String type){
    _pageType = type;
    emit(GetPageTypeWhenNavigateState());
    return _pageType!;
  }


}
