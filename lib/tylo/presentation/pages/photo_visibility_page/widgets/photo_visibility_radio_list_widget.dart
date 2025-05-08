import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/radio_list_visibility_options_widget.dart';

import '../../../../core/resources/constants/firebase_constants.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';

class PhotoVisibilityRadioListWidget extends StatelessWidget {
  const PhotoVisibilityRadioListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RadioListVisibilityOptionsWidget(
      value: context.read<FireStoreCubit>().currentAppUser!.photoVisibility,
      field: FireBaseConstants.photoVisibility,
    );
  }
}
