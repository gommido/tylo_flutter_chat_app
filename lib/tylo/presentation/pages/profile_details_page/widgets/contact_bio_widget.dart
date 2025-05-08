import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';

class ContactBioWidget extends StatelessWidget {
  const ContactBioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: context.read<FireStoreCubit>().streamAppUser!.bio,
      style: Theme.of(context).textTheme.bodyMedium!,
    );
  }
}
