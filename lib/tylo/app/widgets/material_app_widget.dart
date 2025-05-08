import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_routing.dart';
import '../../core/components/bloc_consumer_widget.dart';
import '../../core/resources/constants/app_routes.dart';
import '../../core/resources/constants/app_strings.dart';
import '../../core/services/localization/localizations_delegates.dart';
import '../../core/services/localization/supported_locales.dart';
import '../../core/services/shared_preference/shared_prefs_manager.dart';
import '../../core/utils/themes_manager.dart';
import '../../presentation/controllers/call_controller/call_cubit.dart';
import '../../presentation/controllers/home_controller/home_cubit.dart';
import '../../presentation/pages/calls_home_page/widgets/call_notification_widget.dart';

class MaterialAppWidget extends StatelessWidget {
  const MaterialAppWidget({super.key, required this.appRouting,});
  final AppRouting appRouting;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<HomeCubit, HomeState>(
      listener: (context, state){},
      builder: (context, state){
        return BlocConsumerWidget<CallCubit, CallState>(
          listener: (context, state){},
          builder: (context, state){
            return MaterialApp(
              navigatorKey: context.read<HomeCubit>().navigatorKey,
              debugShowCheckedModeBanner: false,
              title: AppStrings.appName,
              theme: darkTheme(),
              onGenerateRoute: appRouting.generateRoute,
              locale: Locale(
                SharedPrefsManager.getStringData(key: AppStrings.language,)!, '',
              ),
              localizationsDelegates: localizationsDelegates,
              supportedLocales: supportedLocales,
              initialRoute: AppRoutes.currentPage,
              builder: (context, child) {
                return CallNotificationWidget(child: child!,);
              },
              //home: const Page1(),
            );
          },
        );
      },
    );
  }
}
