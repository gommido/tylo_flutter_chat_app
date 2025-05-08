import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/arrow_back_icon.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';
import '../../presentation/controllers/chat_controller/chat_cubit.dart';
import '../../presentation/controllers/home_controller/home_cubit.dart';
import '../helper_functions/capitalize_all_words.dart';
import '../helper_functions/date_format.dart';
import '../helper_functions/detect_language.dart';
import '../resources/color_manager.dart';
import 'bloc_consumer_widget.dart';
import 'custom_widgets/custom_builder.dart';
import 'custom_widgets/custom_container.dart';
import 'custom_widgets/custom_gesture_detector.dart';
import 'custom_widgets/custom_positioned.dart';
import 'custom_widgets/custom_row.dart';
import 'custom_widgets/custom_scaffold.dart';
import 'custom_widgets/custom_sized_box.dart';
import 'custom_widgets/custom_stack.dart';
import 'custom_widgets/custom_text.dart';

class ImageMessageScreenFittedWidget extends StatelessWidget {
  const ImageMessageScreenFittedWidget({super.key, required this.senderName});
  final String senderName;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state){},
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        return SafeArea(
          child: CustomScaffold(
              body: CustomStack(
                children: [
                  CustomContainer(
                    alignment: Alignment.center,
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: ColorManager.black.withOpacity(0.5),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: context.read<ChatCubit>().currentImageMessageText,
                      fit: BoxFit.cover,
                    ),
                  ),
                  CustomPositioned(
                    top: 0,
                    child: CustomContainer(
                      width: size.width,
                      height: size.height / 15,
                      decoration: BoxDecoration(
                          color: ColorManager.black.withOpacity(0.7)
                      ),
                    ),
                  ),
                  CustomPositioned(
                    top: 15,
                    left: 15,
                    child: CustomRow(
                      children: [
                        CustomGestureDetector(
                          onTap: (){
                            context.read<ChatCubit>().setImageMessageScreenFitState();
                          },
                          child: const ArrowBackIcon(),
                        ),
                        CustomSizedBox(width: size.width / 50,),
                        CustomRow(
                          children: [
                            CustomBuilder(
                              builder: (context) {
                                final isLatinWord = detectWordLanguage(senderName);
                                return CustomText(
                                  data: context.read<ChatCubit>().currentSenderId == context.read<HomeCubit>().id ?
                                  '${translate(context, AppStrings.you)} | ' : '${isLatinWord ? capitalizeAllWords(senderName) : senderName} | ',
                                  style: Theme.of(context).textTheme.bodyMedium!,
                                );
                              }
                            ),
                            CustomText(
                              data: formatChatTimesInHours( context.read<ChatCubit>().currentImageMessageTime),
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: ColorManager.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ),
        );
      },
    );
  }
}
