import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_expanded.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/services/localization/localization.dart';
import 'app_bar_logo_widget.dart';

class HomePageSearchWidget extends StatelessWidget {
  const HomePageSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<HomeCubit, HomeState>(
      listener: (context, state){},
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        return CustomRow(
          children: [
            const AppBarLogoWidget(),
            BlocConsumerWidget<HomeCubit, HomeState>(
              listener: (context, state){},
              builder: (context, state){
                if(context.read<HomeCubit>().currentIndex != 0){
                  return CustomSizedBox();
                }
                return CustomExpanded(
                  child: CustomGestureDetector(
                    onTap: (){
                      context.read<HomeCubit>().initSearchedList();
                      context.read<HomeCubit>().getPageTypeWhenNavigate(AppStrings.search);
                      context.read<HomeCubit>().tapToSearch(isTapped: true);
                    },
                    child: CustomContainer(
                      width: size.width,
                      height: size.height / 20,
                      decoration:  BoxDecoration(
                        color: ColorManager.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CustomRow(
                        children: [
                          CustomSizedBox(width: size.width / 50,),
                          CustomIcon(
                            icon: Icons.search,
                            color: ColorManager.grey,
                          ),
                          CustomSizedBox(width: size.width / 50,),
                          CustomText(
                            data: translate(context, AppStrings.search),
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: ColorManager.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

          ],
        );
      },
    );
  }
}

