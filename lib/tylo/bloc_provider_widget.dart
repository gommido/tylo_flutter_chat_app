import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/services/injector.dart';
import 'package:tylo/tylo/presentation/controllers/agora_call_controller/agora_call_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/audio_controller/audio_player_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/auth_controller/auth_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/call_controller/call_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/chat_controller/chat_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/contacts_controller/contacts_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/file_picker_controller/file_picker_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/firestorage_controller/firestorage_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/internet_connection_controller/internet_connection_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/local_storage_controller/local_storage_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/notification_controller/notification_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/user_profile_controller/user_profile_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/video_controller/video_cubit.dart';


class BlocProviderWidget extends StatelessWidget {
  const BlocProviderWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => InternetConnectionCubit()..checkForInternetConnection()..subscribeForNewConnection()),
          BlocProvider(create: (context) => injector<FireStoreCubit>()),
          BlocProvider(create: (context) => injector<FireStorageCubit>()),
          BlocProvider(create: (context) => injector<ChatCubit>()),
          BlocProvider(create: (context) => UserProfileCubit()),
          BlocProvider(create: (context) => injector<AuthCubit>()),
          BlocProvider(create: (context) => VideoCubit()),
          BlocProvider(create: (context) => AudioPlayerCubit()),
          BlocProvider(create: (context) => AgoraCallCubit()),
          BlocProvider(create: (context) => injector<LocalStorageCubit>()
            ..getRegisteredContactsFromLocalStorage()
            ..getNotRegisteredContactsFromLocalStorage()
          ),
          BlocProvider(create: (context) => injector<ContactsCubit>()),
          BlocProvider(create: (context) => injector<FilePickerCubit>()),
          BlocProvider(create: (context) => injector<HomeCubit>()),
          BlocProvider(create: (context) => injector<GroupCubit>()),
          BlocProvider(create: (context) => injector<CallCubit>()),
        ],
        child: child,
    );
  }
}
