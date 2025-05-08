import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_circle_shape_widget.dart';
import 'package:tylo/tylo/core/resources/color_manager.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';
import 'package:tylo/tylo/presentation/pages/registered_contacts_page/widgets/video_call_icon_widget.dart';
import '../../../../core/components/custom_cached_network_image_widget.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_spacer.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/capitalize_all_words.dart';
import '../../../../core/helper_functions/detect_language.dart';
import '../../../../core/services/shared_preference/shared_prefs_manager.dart';
import '../../../../domain/entities/app_contact.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';


class ContactCardWidget extends StatelessWidget {
  ContactCardWidget({super.key, required this.contact, this.isRegistered,});
  final AppContact contact;
  bool? isRegistered;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomRow(
      children: [
        CustomCircleShapeWidget(
          width: size.width / 8,
          height: size.width / 8,
          image: ClipOval(
            child: CustomBuilder(
              builder: (context){
                Map<String, dynamic> photoVisibility = SharedPrefsManager.getMapData(key: AppStrings.photoVisibility);
                if(photoVisibility[contact.id] != null && photoVisibility[contact.id]){
                  if(!context.read<FireStoreCubit>().currentAppUser!.whoBlockMeList.contains(contact.id)){
                    return CustomCachedNetworkImageWidget(
                      width: size.width / 8,
                      height: size.width / 8,
                      imageUrl: contact.image,
                      icon: Icons.person,
                    );
                  }

                }
                return CustomCachedNetworkImageWidget(
                  width: size.width / 8,
                  height: size.width / 8,
                  imageUrl: '',
                  icon: Icons.person,
                );
              },
            ),
          ),
        ),
        CustomSizedBox(width: size.width / 50,),
        CustomColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBuilder(
              builder: (context) {
                final isLatinWord = detectWordLanguage(contact.name);
                return CustomText(
                  data: isLatinWord ? capitalizeAllWords(contact.name) : contact.name,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }
            ),
            CustomText(
              data: isRegistered != null && isRegistered! ? contact.phone.substring(3) :  contact.phone,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: ColorManager.grey,
              ),
            ),
          ],
        ),
        const CustomSpacer(),
        CustomBuilder(
          builder: (context) {
            if(context.read<HomeCubit>().pageType != null && context.read<HomeCubit>().pageType! == AppStrings.calls){
              return VideoCallIconWidget(contact: contact,);
            }
            return CustomSizedBox();
          }
        )
      ],
    );
  }
}


