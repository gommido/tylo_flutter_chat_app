import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/local_storage_controller/local_storage_cubit.dart';
import '../../../../core/components/arrow_back_icon.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_expanded.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_text_field.dart';

class HomePageTextFieldSearchWidget extends StatefulWidget {
  const HomePageTextFieldSearchWidget({super.key});

  @override
  State<HomePageTextFieldSearchWidget> createState() => _HomePageTextFieldSearchWidgetState();
}

class _HomePageTextFieldSearchWidgetState extends State<HomePageTextFieldSearchWidget> {
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<HomeCubit, HomeState>(
      listener: (context, state){},
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        return CustomContainer(
          width: size.width,
          child: CustomRow(
            children: [
              CustomGestureDetector(
                onTap: ()=> context.read<HomeCubit>().tapToSearch(),
                child: const ArrowBackIcon(),
              ),
              CustomSizedBox(width: size.width / 50,),
              CustomExpanded(
                  child: CustomTextField(
                    onChanged: (String value){
                     if(value.trim().isNotEmpty){
                       context.read<HomeCubit>().searchForContacts(
                         contacts: context.read<LocalStorageCubit>().storedRegisteredContacts,
                         searchedContact:value,
                       );
                     }else{
                       context.read<HomeCubit>().clearSearchedList();
                     }
                    },
                    border: InputBorder.none,
                    label: translate(context, AppStrings.search),
                    maxLines: 1,
                    focusNode: _searchFocusNode,
                    controller: _searchController,
                    textInputType: TextInputType.text,
                    height: size.height / 15,
                    width: size.width,
                  )
              )
            ],
          ),
        );
      },
    );
  }
}


