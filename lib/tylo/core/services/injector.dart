
import 'package:get_it/get_it.dart';
import 'package:tylo/tylo/core/utils/file_picker_manager/file_picker_manager.dart';
import 'package:tylo/tylo/data/data_sources/local/local_storage_data_source.dart';
import 'package:tylo/tylo/data/data_sources/remote/call_data_source/call_data_source.dart';
import 'package:tylo/tylo/data/data_sources/remote/chat_data_source/chat_data_source.dart';
import 'package:tylo/tylo/data/data_sources/remote/firebase_firestore/firestore_data_source.dart';
import 'package:tylo/tylo/data/data_sources/remote/firebase_storage/fire_storage_data_source.dart';
import 'package:tylo/tylo/data/data_sources/remote/group_data_source/group_data_source.dart';
import 'package:tylo/tylo/data/data_sources/remote/notification_data_source/notification_data_source.dart';
import 'package:tylo/tylo/data/repositories_impl/firestore_repository_impl/firestore_repository_impl.dart';
import 'package:tylo/tylo/data/repositories_impl/local_storage_repository_impl/local_stoarge_repository_impl.dart';
import 'package:tylo/tylo/data/repositories_impl/notification_repository_impl/notification_repository_impl.dart';
import 'package:tylo/tylo/domain/repositories/firestore_repository/firestore_repository.dart';
import 'package:tylo/tylo/domain/repositories/local_storage_repository/local_storage_epository.dart';
import 'package:tylo/tylo/domain/repositories/notification_repository/notification_repository.dart';
import 'package:tylo/tylo/domain/use_cases/call/create_call_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/call/create_room_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/call/delete_room_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/call/get_call_room_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/call/update_call_data_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/call/update_room_data_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/chat/delete_chat_last_messages_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/chat/delete_chat_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/chat/delete_message_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/chat/get_chat_messages_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/chat/get_my_chats_last_messages_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/chat/get_unseen_messages_count_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/chat/update_last_message_typing_status_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/chat/update_message_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/chat/send_message_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/chat/set_last_message_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/chat/update_user_typing_status_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/chat/update_unseen_last_message_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/chat/update_unseen_message_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/firebase_auth/get_current_user_id_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/firebase_firestore/create_app_user_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/firebase_firestore/delete_firebase_document_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/firebase_firestore/update_app_user_data_usecase.dart';
import 'package:tylo/tylo/domain/use_cases/firebase_storage/delete_stored_file_usecase.dart';
import 'package:tylo/tylo/domain/use_cases/firebase_storage/upload_file_usecase.dart';
import 'package:tylo/tylo/domain/use_cases/group/delete_group_message_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/group/delete_group_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/group/update_group_data_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/group/add_or_remove_contact_from_group_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/group/create_group_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/group/get_group_details_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/group/get_group_messages_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/group/get_my_groups_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/group/send_group_message_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/group/set_group_last_message_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/group/update_group_message_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/local_storage/save_contacts_to_local_storage_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/local_storage/get_contacts_from_local_storage_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/notification/send_notification_use_case.dart';
import 'package:tylo/tylo/presentation/controllers/auth_controller/auth_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/call_controller/call_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/chat_controller/chat_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/contacts_controller/contacts_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/file_picker_controller/file_picker_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/firestorage_controller/firestorage_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/local_storage_controller/local_storage_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/notification_controller/notification_cubit.dart';
import '../../data/data_sources/remote/auth/firebase_auth_data_source.dart';
import '../../data/repositories_impl/auth_repository_impl/firebase_auth_repository_impl.dart';
import '../../data/repositories_impl/call_repository_impl/call_repository_impl.dart';
import '../../data/repositories_impl/chat_repository_impl/chat_repository_impl.dart';
import '../../data/repositories_impl/firestorage_repository_impl/firestorage_repository_impl.dart';
import '../../data/repositories_impl/group_repository_impl/group_repository_impl.dart';
import '../../domain/repositories/auth_repository/firebase_auth_repository.dart';
import '../../domain/repositories/call_repository/call_repository.dart';
import '../../domain/repositories/chat_repository/chat_repository.dart';
import '../../domain/repositories/fire_storage_repository/firestorage_repository.dart';
import '../../domain/repositories/group_repository/group_repository.dart';
import '../../domain/use_cases/call/delete_calls_use_case.dart';
import '../../domain/use_cases/call/get_my_calls_use_case.dart';
import '../../domain/use_cases/chat/get_unseen_new_chats_count_use_case.dart';
import '../../domain/use_cases/firebase_auth/sign_up_with_phone_number_usecase.dart';
import '../../domain/use_cases/firebase_firestore/get_online_users_use_case.dart';
import '../../domain/use_cases/firebase_firestore/update_block_contact_status_use_case.dart';
import '../../domain/use_cases/firebase_firestore/check_if_user_exist_by_field_use_case.dart';
import '../../domain/use_cases/firebase_firestore/get_user_as_future_use_case.dart';
import '../../domain/use_cases/firebase_firestore/get_user_as_stream_use_case.dart';


final injector = GetIt.instance;

void initGetIt() {

  /// Firebase Auth ///

  // FireBaseAuthRepository
  injector.registerLazySingleton<FireBaseAuthRepository>(() => FireBaseAuthRepositoryImpl(injector()));
  // FireBaseAuthDataSource
  injector.registerLazySingleton<FireBaseAuthDataSource>(() => FireBaseAuthDataSource());
  // SignUpWithPhoneNumberUseCase
  injector.registerLazySingleton<SignUpWithPhoneNumberUseCase>(() => SignUpWithPhoneNumberUseCase(injector(),));

  // GetCurrentUserIdUseCase
  injector.registerLazySingleton<GetCurrentUserIdUseCase>(() => GetCurrentUserIdUseCase(injector(),));
  // FireBaseAuthCubit
  //injector.registerLazySingleton<FireBaseAuthCubit>(() => FireBaseAuthCubit(injector(), injector(), injector(), injector()));

  injector.registerLazySingleton<AuthCubit>(() => AuthCubit(injector(),  injector()));



  injector.registerLazySingleton<FilePickerCubit>(() => FilePickerCubit(injector()));
  injector.registerLazySingleton<FilePickerManager>(() => FilePickerManager());


  /// Firebase FireStore ///

  // FireStoreRepository
  injector.registerLazySingleton<FireStoreRepository>(() => FireStoreRepositoryImpl(injector()));
  // FireStoreDataSource
  injector.registerLazySingleton<FireStoreDataSource>(() => FireStoreDataSource());

  // CreateAppUserUseCase

  // CreateAppUserUseCase
  injector.registerLazySingleton<CreateAppUserUseCase>(() => CreateAppUserUseCase(injector()));
  // FireStoreCubit
  injector.registerLazySingleton<FireStoreCubit>(() => FireStoreCubit(injector(), injector(), injector(), injector(), injector(), injector(), injector(), injector()));

  // UpdateAppUserDataUseCase
  injector.registerLazySingleton<UpdateAppUserDataUseCase>(() => UpdateAppUserDataUseCase(injector()));
  injector.registerLazySingleton<CheckIfUserExistByFieldUseCase>(() => CheckIfUserExistByFieldUseCase(injector()));
  // GetUserDataUseCase
  injector.registerLazySingleton<GetUserAsFutureUseCase>(() => GetUserAsFutureUseCase(injector()));

  injector.registerLazySingleton<GetUserAsStreamUseCase>(() => GetUserAsStreamUseCase(injector()));



  injector.registerLazySingleton<DeleteFirebaseDocumentUseCase>(() => DeleteFirebaseDocumentUseCase(injector()));

  injector.registerLazySingleton<UpdateBlockContactStatusUseCase>(() => UpdateBlockContactStatusUseCase(injector()));

  injector.registerLazySingleton<GetOnlineUsersUseCase>(() => GetOnlineUsersUseCase(injector()));


  injector.registerLazySingleton<FireStorageCubit>(() => FireStorageCubit(injector(), injector()));
  injector.registerLazySingleton<FireStorageRepository>(() => FireStorageRepositoryImpl(injector()));
  injector.registerLazySingleton<FireStorageDataSource>(() => FireStorageDataSource());
  injector.registerLazySingleton<UploadFileToFireStorageUseCase>(() => UploadFileToFireStorageUseCase(injector()));
  injector.registerLazySingleton<DeleteStoredFileUseCase>(() => DeleteStoredFileUseCase(injector()));

  injector.registerLazySingleton<HomeCubit>(() => HomeCubit());

  injector.registerLazySingleton<ContactsCubit>(() => ContactsCubit(injector(), injector()));


  injector.registerLazySingleton<ChatCubit>(() => ChatCubit(injector(), injector(), injector(), injector(), injector(), injector(), injector(),  injector(), injector(),  injector(), injector(), injector(), injector(), injector(), injector(), injector(), injector()));


  injector.registerLazySingleton<ChatDataSource>(() => ChatDataSource());
  injector.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(injector()));
  injector.registerLazySingleton<SendMessageUseCase>(() => SendMessageUseCase(injector()));
  injector.registerLazySingleton<GetMyChatsLastMessagesUseCase>(() => GetMyChatsLastMessagesUseCase(injector()));
  injector.registerLazySingleton<SetLastMessageUseCase>(() => SetLastMessageUseCase(injector()));
  injector.registerLazySingleton<GetChatMessagesUseCase>(() => GetChatMessagesUseCase(injector()));
  injector.registerLazySingleton<GetUnseenMessagesCountUseCase>(() => GetUnseenMessagesCountUseCase(injector()));

  injector.registerLazySingleton<DeleteMessageUseCase>(() => DeleteMessageUseCase(injector()));
  injector.registerLazySingleton<UpdateLastMessageTypingStatusUseCase>(() => UpdateLastMessageTypingStatusUseCase(injector()));
  injector.registerLazySingleton<DeleteChatUseCase>(() => DeleteChatUseCase(injector()));
  injector.registerLazySingleton<DeleteChatLastMessagesUseCase>(() => DeleteChatLastMessagesUseCase(injector()));

  injector.registerLazySingleton<UpdateUserTypingStatusUseCase>(() => UpdateUserTypingStatusUseCase(injector()));
  injector.registerLazySingleton<UpdateUnSeenMessageUseCase>(() => UpdateUnSeenMessageUseCase(injector()));
  injector.registerLazySingleton<UpdateUnSeenLastMessageUseCase>(() => UpdateUnSeenLastMessageUseCase(injector()));
  injector.registerLazySingleton<UpdateMessageUseCase>(() => UpdateMessageUseCase(injector()));
  injector.registerLazySingleton<GetUnseenNewChatsCountUseCase>(() => GetUnseenNewChatsCountUseCase(injector()));


  injector.registerLazySingleton<GroupCubit>(() => GroupCubit(injector(), injector(), injector(), injector(), injector(), injector(), injector(), injector(), injector(), injector(),  injector(),  injector(), injector(), injector()));
  injector.registerLazySingleton<GroupDataSource>(() => GroupDataSource());
  injector.registerLazySingleton<GroupRepository>(() => GroupRepositoryImpl(injector()));
  injector.registerLazySingleton<CreateGroupUseCase>(() => CreateGroupUseCase(injector()));
  injector.registerLazySingleton<UpdateGroupDataUseCase>(() => UpdateGroupDataUseCase(injector()));
  injector.registerLazySingleton<UpdateGroupMessageUseCase>(() => UpdateGroupMessageUseCase(injector()));
  injector.registerLazySingleton<DeleteGroupMessageUseCase>(() => DeleteGroupMessageUseCase(injector()));
  injector.registerLazySingleton<DeleteGroupUseCase>(() => DeleteGroupUseCase(injector()));

  injector.registerLazySingleton<GetGroupDetailsUseCase>(() => GetGroupDetailsUseCase(injector()));
  injector.registerLazySingleton<GetMyGroupsUseCase>(() => GetMyGroupsUseCase(injector()));
  injector.registerLazySingleton<SendGroupMessageUseCase>(() => SendGroupMessageUseCase(injector()));
  injector.registerLazySingleton<GetGroupMessagesUseCase>(() => GetGroupMessagesUseCase(injector()));
  injector.registerLazySingleton<SetGroupLastMessageUseCase>(() => SetGroupLastMessageUseCase(injector()));
  injector.registerLazySingleton<AddOrRemoveContactFromGroupUseCase>(() => AddOrRemoveContactFromGroupUseCase(injector()));

  injector.registerLazySingleton<CallCubit>(() => CallCubit(injector(), injector(),injector(), injector(), injector(), injector(), injector(), injector(), injector(),));
  injector.registerLazySingleton<CallDataSource>(() => CallDataSource());
  injector.registerLazySingleton<CallRepository>(() => CallRepositoryImpl(injector()));
  injector.registerLazySingleton<CreateRoomUseCase>(() => CreateRoomUseCase(injector()));
  injector.registerLazySingleton<GetCallRoomUseCase>(() => GetCallRoomUseCase(injector()));
  injector.registerLazySingleton<UpdateRoomDataUseCase>(() => UpdateRoomDataUseCase(injector()));
  injector.registerLazySingleton<CreateCallUseCase>(() => CreateCallUseCase(injector()));
  injector.registerLazySingleton<DeleteRoomUseCase>(() => DeleteRoomUseCase(injector()));
  injector.registerLazySingleton<GetMyCallsUseCase>(() => GetMyCallsUseCase(injector()));
  injector.registerLazySingleton<UpdateCallDataUseCase>(() => UpdateCallDataUseCase(injector()));
  injector.registerLazySingleton<DeleteCallsUseCase>(() => DeleteCallsUseCase(injector()));


  injector.registerLazySingleton<LocalStorageDataSource>(() => LocalStorageDataSource());
  injector.registerLazySingleton<LocalStorageRepository>(() => LocalStorageRepositoryImpl(injector()));
  injector.registerLazySingleton<LocalStorageCubit>(() => LocalStorageCubit(injector(), injector()));
  injector.registerLazySingleton<SaveContactsToLocalStorageUseCase>(() => SaveContactsToLocalStorageUseCase(injector()));
  injector.registerLazySingleton<GetContactsFromLocalStorageUseCase>(() => GetContactsFromLocalStorageUseCase(injector()));


}