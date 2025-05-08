import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';

import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';

class CallBackgroundImageWidget extends StatelessWidget {
  const CallBackgroundImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumerWidget<FireStoreCubit, FireStoreState>(
        listener: (context, state){},
        builder: (context, state){
          return CustomContainer(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(context.read<FireStoreCubit>().streamAppUser!.photo),
                  fit: BoxFit.cover,
                  opacity: 0.1,
                )
            ),
          );
        },
    );
  }
}
