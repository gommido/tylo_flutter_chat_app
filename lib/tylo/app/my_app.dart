import 'package:flutter/material.dart';
import 'package:tylo/tylo/app/widgets/material_app_widget.dart';
import '../app_routing.dart';
import '../bloc_provider_widget.dart';
import '../core/components/bloc_consumer_widget.dart';
import '../presentation/controllers/internet_connection_controller/internet_connection_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouting,});
  final AppRouting appRouting;

  @override
  Widget build(BuildContext context) {
    return BlocProviderWidget(
      child: BlocConsumerWidget<InternetConnectionCubit, InternetConnectionState>(
        listener: (context, state){},
        builder: (context, state){
          return MaterialAppWidget(appRouting: appRouting);
        },
      ),
    );
  }
}