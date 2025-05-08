import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';
import 'package:tylo/tylo/presentation/controllers/audio_controller/audio_player_cubit.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/call_controller/call_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';
import '../../home_page/widgets/call_notification_caller_name.dart';
import '../../home_page/widgets/call_notification_calling_tile_widget.dart';
import '../../home_page/widgets/call_notification_cancel_call_widget.dart';
import '../../home_page/widgets/call_notification_reply_call_widget.dart';

class CallNotificationCallerInfoWidget extends StatefulWidget {
  const CallNotificationCallerInfoWidget({super.key});

  @override
  State<CallNotificationCallerInfoWidget> createState() => _CallNotificationCallerInfoWidgetState();
}

class _CallNotificationCallerInfoWidgetState extends State<CallNotificationCallerInfoWidget> {
  late AudioPlayerCubit _audioPlayerCubit;


  @override
  void initState() {
    super.initState();
    _audioPlayerCubit = BlocProvider.of<AudioPlayerCubit>(context, listen: false);
    _audioPlayerCubit.initPlayerController();
  }

  @override
  void dispose() {
    _audioPlayerCubit.onStop();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumerWidget<CallCubit, CallState>(
        listener: (context, state){},
        builder: (context, state){
          return CustomContainer(
            alignment: Alignment.center,
            width: size.width / 1.5,
            height: size.height / 5,
            decoration: BoxDecoration(
              color: ColorManager.callCardBg,
              border: Border.all(
                color: ColorManager.white.withOpacity(0.1),
              ),
              // shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(context.read<CallCubit>().room!.callerImage,),
                fit: BoxFit.cover,
                opacity: 0.2,
              ),
            ),

            child: CustomColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CallNotificationCallerName(),
                CustomSizedBox(height: size.height / 50,),
                const CallNotificationCallingTileWidget(),
                CustomSizedBox(height: size.height / 50,),
                CustomRow(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CallNotificationCancelCallWidget(),
                    CustomBuilder(
                      builder: (context){
                        if(context.read<CallCubit>().room != null && context.read<CallCubit>().room!.callerId != context.read<HomeCubit>().id){
                          return CustomRow(
                            children: [
                              CustomSizedBox(width: size.width / 10,),
                              const CallNotificationReplyCallWidget(),
                            ],
                          );
                        }
                        return CustomSizedBox();
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
    );
  }
}
