import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/animation_navigator/fade_animation.dart';
import 'package:tylo/tylo/core/resources/constants/app_routes.dart';
import 'package:tylo/tylo/presentation/pages/add_new_contact_page/add_new_contact_page.dart';
import 'package:tylo/tylo/presentation/pages/chat_room_page/chat_room_page.dart';
import 'package:tylo/tylo/presentation/pages/group_details_page/group_details_page.dart';
import 'package:tylo/tylo/presentation/pages/profile_details_page/profile_details_page.dart';
import 'package:tylo/tylo/presentation/pages/registered_contacts_page/registered_contacts_page.dart';
import 'package:tylo/tylo/presentation/pages/not_registered_contacts_page/not_registered_contacts_page.dart';
import 'package:tylo/tylo/presentation/pages/create_new_group_page/new_group_page.dart';
import 'package:tylo/tylo/presentation/pages/group_chat_room_page/group_chat_room_page.dart';
import 'package:tylo/tylo/presentation/pages/home_page/home_layout_page.dart';
import 'package:tylo/tylo/presentation/pages/phone_number_signing_up_page/phone_number_signing_up_page.dart';
import 'package:tylo/tylo/presentation/pages/photo_visibility_page/photo_visibility_page.dart';
import 'package:tylo/tylo/presentation/pages/app_language_page/app_language_page.dart';
import 'package:tylo/tylo/presentation/pages/block_list_page/block_list_page.dart';
import 'package:tylo/tylo/presentation/pages/last_seen_online_status_page/last_seen_and_online_status_page.dart';
import 'package:tylo/tylo/presentation/pages/privacy_page/privacy_page.dart';
import 'package:tylo/tylo/presentation/pages/settings_page/settings_page.dart';
import 'package:tylo/tylo/presentation/pages/edit_profile_page/edit_profile_page.dart';
import 'package:tylo/tylo/presentation/pages/add_profile_name_page/add_profile_name_page.dart';
import 'package:tylo/tylo/presentation/pages/otp_verification_page/otp_verification_page.dart';
import 'package:tylo/tylo/presentation/pages/pick_profile_image_page/pick_profile_image_page.dart';
import 'package:tylo/tylo/presentation/pages/get_started_page/get_started_page.dart';
import 'package:tylo/tylo/presentation/pages/video_call_page/video_call_page.dart';
import 'current_page.dart';

class AppRouting {

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case AppRoutes.currentPage:
        return navigateFadeAnimation(settings,  const CurrentPage(),);
      case AppRoutes.getStartedPage:
        return navigateFadeAnimation(settings,  const GetStartedPage(),);
      case AppRoutes.otpVerificationPage:
        return navigateFadeAnimation(settings,  const OtpVerificationPage(),);
      case AppRoutes.addProfileNamePage:
        return navigateFadeAnimation(settings,  const AddProfileNamePage(),);
      case AppRoutes.pickProfileImagePage:
        return navigateFadeAnimation(settings,  const PickProfileImagePage(),);
      case AppRoutes.phoneSignUpPage:
        return navigateFadeAnimation(settings,  const PhoneNumberSigningUpPage(),);
      case AppRoutes.homeLayoutPage:
        return navigateFadeAnimation(settings,  const HomeLayoutPage(),);
      case AppRoutes.settingsPage:
        return navigateFadeAnimation(settings,  const SettingsPage(),);
      case AppRoutes.newGroupPage:
        return navigateFadeAnimation(settings,  const NewGroupPage(),);
      case AppRoutes.registeredContactsPage:
        return navigateFadeAnimation(settings,  const RegisteredContactsPage(),);
      case AppRoutes.notRegisteredContactsPage:
        return navigateFadeAnimation(settings,  const NotRegisteredContactsPage(),);
      case AppRoutes.chatRoomPage:
        return navigateFadeAnimation(settings,  const ChatRoomPage());
      case AppRoutes.groupChatRoomPage:
        final groupId = settings.arguments as String;
        return navigateFadeAnimation(settings,  GroupChatRoomPage(groupId: groupId,),);
      case AppRoutes.profileDetailsPage:
        return navigateFadeAnimation(settings,  const ProfileDetailsPage(),);
      case AppRoutes.editProfilePage:
        return navigateFadeAnimation(settings,  const EditProfilePage(),);
      case AppRoutes.blockListPage:
        return navigateFadeAnimation(settings,  const BlockListPage(),);
      case AppRoutes.appLanguagePage:
        return navigateFadeAnimation(settings,  const AppLanguagePage(),);
      case AppRoutes.privacyPage:
        return navigateFadeAnimation(settings,  const PrivacyPage(),);
      case AppRoutes.lastSeenAndOnlineStatusPage:
        return navigateFadeAnimation(settings,  const LastSeenAndOnlineStatusPage(),);
      case AppRoutes.photoVisibilityPage:
        return navigateFadeAnimation(settings,  const PhotoVisibilityPage(),);
      case AppRoutes.groupDetailsPage:
        return navigateFadeAnimation(settings,  const GroupDetailsPage(),);
      case AppRoutes.videoCallPage:
        bool? isCallMadeByMe = settings.arguments as bool;
        return navigateFadeAnimation(settings,  VideoCallPage(isCallMadeByMe: isCallMadeByMe,),);
      case AppRoutes.addNewContactPage:
        return navigateFadeAnimation(settings,  const AddNewContactPage(),);
    }
    return null;
  }
}