import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tylo/tylo/core/components/custom_alert_dialog_widget.dart';
import 'package:tylo/tylo/core/components/custom_circle_shape_widget.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_gesture_detector.dart';
import 'package:tylo/tylo/core/helper_functions/navigator/navigator_pop.dart';
import 'package:tylo/tylo/core/resources/color_manager.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';
import 'package:tylo/tylo/core/utils/message_type_enum.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_internet_checker.dart';
import '../../../../core/components/custom_widgets/custom_snack_bar.dart';
import '../../../../core/helper_functions/capitalize_all_words.dart';
import '../../../../core/helper_functions/detect_language.dart';
import '../../../../core/helper_functions/navigator/push_named_navigator.dart';
import '../../../../core/resources/constants/app_routes.dart';
import '../../../../domain/entities/app_contact.dart';
import '../../../controllers/call_controller/call_cubit.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';


class VideoCallIconWidget extends StatelessWidget {
  const VideoCallIconWidget({super.key, required this.contact});
  final AppContact contact;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomGestureDetector(
      onTap: (){
        showDialog(
            context: context,
            builder: (context){
              return CustomAlertDialogWidget(
                  title: '${translate(context, AppStrings.makeVideoCallWith)} ${contact.name.split(' ').first}?',
                  onPressed: (){
                    CustomInternetChecker.checkInternetAvailability(
                      context: context,
                      onInternetAvailable: (){
                        if(!context.read<FireStoreCubit>().currentAppUser!.blockList.contains(contact.id)){
                          if(!context.read<FireStoreCubit>().currentAppUser!.whoBlockMeList.contains(contact.id)){
                            final onlineUsers = context.read<FireStoreCubit>().onlineUsers.where((user)=> user.id == contact.id).toList();
                            if(onlineUsers.isNotEmpty && onlineUsers.first.lastSeen == null){
                              navigateAndPop(context);
                              pushNamed(route: AppRoutes.videoCallPage, context: context, arguments: true,);
                              context.read<CallCubit>().setIsRoomJoinedData(isJoined: true);
                              context.read<CallCubit>().createRoom(
                                callerId: context.read<HomeCubit>().id,
                                callReceiverId: contact.id,
                                callerName: context.read<FireStoreCubit>().currentAppUser!.name,
                                callerImage: context.read<FireStoreCubit>().currentAppUser!.photo,
                              );
                              context.read<ChatCubit>().sendMessage(
                                  sentBy: context.read<HomeCubit>().id,
                                  sentTo: onlineUsers.first.id,
                                  messageText: 'Video call',
                                  receiverName: onlineUsers.first.name,
                                  receiverImage: onlineUsers.first.photo,
                                  messageType: MessageType.videoCall,
                                  token: onlineUsers.first.token,
                                secondUserPhotoVisibility: onlineUsers.first.photoVisibility,
                              );
                            }else{
                              navigateAndPop(context);
                              final name = contact.name.split(' ').first;
                              final isLatinWord = detectWordLanguage(name);
                              CustomToast.show(title: '${isLatinWord ? capitalizeAllWords(name) : name} ${translate(context, 'notAvailable')}', toastLength: Toast.LENGTH_LONG,);
                            }
                          }else{
                            navigateAndPop(context);
                            CustomToast.show(title: translate(context, AppStrings.thisContactBlockedYou), toastLength: Toast.LENGTH_LONG);
                          }
                        }else{
                          navigateAndPop(context);
                          CustomToast.show(title: translate(context, AppStrings.youBlockedThisContact), toastLength: Toast.LENGTH_LONG);
                        }

                      },
                    );

                  },
              );
            },
        );
      },
      child: CustomCircleShapeWidget(
          width: size.width / 8,
          height: size.width / 8,
        color: ColorManager.transparent,
        image: CustomIcon(
          icon: Icons.video_camera_back_rounded,
          color: ColorManager.green,
        ),
      ),
    );
  }
}
