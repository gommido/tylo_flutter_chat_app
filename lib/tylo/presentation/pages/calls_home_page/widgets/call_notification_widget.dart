
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_builder.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import 'package:tylo/tylo/presentation/controllers/call_controller/call_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_positioned.dart';
import '../../../../core/components/custom_widgets/custom_stack.dart';
import 'call_notification_caller_info_widget.dart';
import 'glowoing_call_widget.dart';


class CallNotificationWidget extends StatefulWidget {
  const CallNotificationWidget({super.key, required this.child,});
  final Widget child;


  @override
  State<CallNotificationWidget> createState() => _CallNotificationWidgetState();
}

class _CallNotificationWidgetState extends State<CallNotificationWidget> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      BlocProvider.of<CallCubit>(context, listen: false)
          .initOffsetAndSizeData(size: MediaQuery.of(context).size);
    });
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumerWidget<CallCubit, CallState>(
      listener: (context, state){},
      builder: (context, state){
        return CustomStack(
          children: [
            widget.child,
            CustomBuilder(
              builder: (context){
                if(context.read<CallCubit>().room != null){
                  if(!context.read<CallCubit>().room!.isRespond){
                    return CustomPositioned(
                      left: context.read<CallCubit>().offset.dx,
                      top: context.read<CallCubit>().offset.dy,
                      child: CustomGestureDetector(
                        onTap: (){},
                        onPanUpdate: context.read<CallCubit>().handlePanUpdate,
                        child: CustomBuilder(
                          builder: (context) {
                            if(context.read<CallCubit>().room != null){
                              return CustomStack(
                                children: [
                                  AnimatedGlowingContainer(
                                    width: size.width / 1.5,
                                    height: size.height / 5,
                                  ),
                                  const CallNotificationCallerInfoWidget(),
                                ],
                              );
                            }
                            return CustomSizedBox();
                          }
                        ),
                      ),
                    );
                  }
                }
                return CustomSizedBox();
              },
            )
          ],
        );
      },
    );
  }
}

