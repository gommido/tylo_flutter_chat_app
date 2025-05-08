import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tylo/tylo/domain/use_cases/group/delete_group_message_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/group/delete_group_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/group/update_group_message_use_case.dart';
import 'package:tylo/tylo/presentation/controllers/file_picker_controller/file_picker_cubit.dart';
import 'package:tylo/tylo/domain/entities/group.dart';
import 'package:tylo/tylo/domain/entities/group_message.dart';
import 'package:tylo/tylo/domain/use_cases/group/update_group_data_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/group/add_or_remove_contact_from_group_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/group/create_group_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/group/get_group_details_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/group/get_group_messages_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/group/get_my_groups_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/group/send_group_message_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/group/set_group_last_message_use_case.dart';
import 'package:tylo/tylo/presentation/controllers/firestorage_controller/firestorage_cubit.dart';
import '../../../core/helper_functions/get_video_thumbnail.dart';
import '../../../core/shared/temporary_directory_manager.dart';
import '../../../core/shared/uuid_manager.dart';
import '../../../core/utils/file_manager/ffmpeg_commands.dart';
import '../../../core/utils/file_manager/file_manager.dart';
import '../../../core/utils/message_type_enum.dart';
import '../../../domain/entities/app_user.dart';
import '../firestore_controller/fire_store_cubit.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  GroupCubit(
      this.createGroupUseCase,
      this.fireStoreCubit,
      this.updateGroupDataUseCase,
      this.fireStorageCubit,
      this.getGroupDetailsUseCase,
      this.getMyGroupsUseCase,
      this.sendGroupMessageUseCase,
      this.getGroupMessagesUseCase,
      this.setGroupLastMessageUseCase,
      this._addOrRemoveContactFromGroupUseCase,
      this.filePickerCubit,
      this._updateGroupMessageUseCase,
      this._deleteGroupUseCase,
      this._deleteGroupMessageUseCase,
      ) : super(GroupInitial()){
    _isContactPicked = [];
    _selectedContacts = [];

  }
  final CreateGroupUseCase createGroupUseCase;
  final FireStoreCubit fireStoreCubit;
  final UpdateGroupDataUseCase updateGroupDataUseCase;
  final FireStorageCubit fireStorageCubit;
  final GetGroupDetailsUseCase getGroupDetailsUseCase;
  final GetMyGroupsUseCase getMyGroupsUseCase;
  final SendGroupMessageUseCase sendGroupMessageUseCase;
  final GetGroupMessagesUseCase getGroupMessagesUseCase;
  final SetGroupLastMessageUseCase setGroupLastMessageUseCase;
  final AddOrRemoveContactFromGroupUseCase _addOrRemoveContactFromGroupUseCase;
  final FilePickerCubit filePickerCubit;
  final UpdateGroupMessageUseCase _updateGroupMessageUseCase;
  final DeleteGroupUseCase _deleteGroupUseCase;
  final DeleteGroupMessageUseCase _deleteGroupMessageUseCase;

  late List<bool> _isContactPicked;
  List<bool> get isContactPicked => _isContactPicked;

  late List<String> _selectedContacts;
  List<String> get selectedContacts => _selectedContacts;

  final List<String> _groupPopMenuItems =[
    'addContact',
    'removeContact',
    'deleteGroup',
  ];
  List<String> get groupPopMenuItems => _groupPopMenuItems;

  void checkIsContactPicked(){
    _isContactPicked.add(false);
    emit(CheckIsContactPickedState());
  }

  void addContactToSelected(String id){
    _selectedContacts.add(id);
    emit(AddContactToSelectedState());
  }

  void removeContactFromSelected(String id){
    _selectedContacts.remove(id);
    emit(RemoveContactFromSelectedState());
  }

  void pickGroupMembers(int index){
    _isContactPicked[index] = !_isContactPicked[index];
    emit(PickGroupMembersState());
  }

  void clearSelectedUsers(){
    _selectedContacts.clear();
    _isContactPicked.clear();
    emit(ClearSelectedContactsState());
  }



  String? _newGroupCreatedId;
  String? get newGroupCreatedId => _newGroupCreatedId;

  Future<void> createGroup({
    required String ownerId,
    File? file,
  })async{
    emit(CreateGroupLoadingsState());
    _newGroupCreatedId = getUuid();
    _selectedContacts.add(fireStoreCubit.currentAppUser!.id);
    final result = await createGroupUseCase.createGroup(
        id: _newGroupCreatedId!,
        ownerId: ownerId,
        ownerName: fireStoreCubit.currentAppUser!.name,
        ownerImage: fireStoreCubit.currentAppUser!.photo,
        name: _groupNameController.text,
        image: '',
        membersIds: _selectedContacts,
    );
    result.fold(
          (l) => emit(CreateGroupFailureState(l.message)),
          (r){
            emit(CreateGroupSuccessState());
            if(file != null){
              fireStorageCubit.uploadFileToFireStorage(folder: 'images', file: file).then((imageUrl){
                updateGroupData(
                  field: 'image',
                  value: imageUrl,
                ).then((value){});
              });
            }
          });
  }

  Group? _group;
  Group? get group => _group;

  Group? getGroupDetails({required String id}){
    try {
      getGroupDetailsUseCase.getGroupDetails(id: id).listen((event)async {
        _group = event;
        emit(GetGroupDetailsSuccessState());
      });
    } on FirebaseException catch (error) {
      emit(GetGroupMessagesFailureState(error.message.toString()));
    }
    return _group;
  }

  List<AppUser>? _groupMembers;
  List<AppUser>? get groupMembers => _groupMembers;
  Future<List<AppUser>> getGroupMembers()async{
    try{
      _groupMembers = [];
      for(final member in _group!.membersIds){
        final user = await fireStoreCubit.getUserAsFuture(id: member);
        groupMembers!.add(user!);
        emit(GetGroupMembersSuccessState());
      }
    } catch (error){
      emit(GetGroupMembersFailureState(error.toString()));
    }
    return groupMembers!;
  }


  Future<void> updateGroupData({
    required String field,
    dynamic value,
})async{
    emit(UpdateGroupDataLoadingState());
    final result = await updateGroupDataUseCase.updateAppUserData(id: _group!.id, field: field, value: value);
    result.fold((l) => emit(UpdateGroupDataFailureState(l.message)),
            (r){
              emit(UpdateGroupDataSuccessState());
            });
  }


  late TextEditingController _groupNameController;
  TextEditingController get groupNameController => _groupNameController;

  void initNameController(){
    _groupNameController = TextEditingController();
    emit(InitGroupNameControllerState());
  }


  void disposeNameController(){
    _groupNameController.dispose();
    emit(DisposeGroupNameControllerState());
  }

  late List<Group> _groups;

  List<Group> get groups => _groups;
  List<Group> getMyGroups({required String id}) {
    try {
      _groups = [];
     getMyGroupsUseCase.getMyGroups(id: id,).listen((myGroups) {
       _groups = myGroups;
       emit(GetMyGroupsSuccessState());
     });
    } on FirebaseException catch (error) {
      emit(GetMyGroupsFailureState(error.message.toString()));
    }
    return _groups;
  }

  void clearMyGroupsList(){
    _groups.clear();
  }

  late String _messageId;
  Future<void> sendGroupMessage({
    required String sentBy,
    required String messageText,
    required MessageType messageType,
    String? videoMessageThumbnail,
    int? voiceNoteDuration,
  }) async {
    _messageId = getUuid();
    final messageTime = Timestamp.now();
    final result = await sendGroupMessageUseCase.sendGroupMessage(
        messageText: messageText,
        senderName: fireStoreCubit.currentAppUser!.name,
        senderImage: fireStoreCubit.currentAppUser!.photo,
        sentBy: sentBy,
        groupId: _group!.id,
        messageId: _messageId,
        messageTime: messageTime,
        messageType: messageType,
       videoMessageThumbnail: videoMessageThumbnail,
      voiceNoteDuration: voiceNoteDuration,
    );
    result.fold(
            (l) => emit(SendGroupMessageFailureState(l.message)),
            (r){
          emit(SendGroupMessageSuccessState());
          setGroupLastMessage(lastMessage: messageText, messageTime: messageTime, messageType: messageType);
        });
  }
  
  Future<void> updateGroupMessage({
    required String messageId,
    required String field,
    String? value,
})async {
    final result = await _updateGroupMessageUseCase.updateGroupMessage(groupId:  _group!.id, messageId: messageId, field: field, value: value,);
    result.fold(
            (l) => emit(UpdateGroupMessageFailureState(l.message)),
            (r){
          emit(UpdateGroupMessageSuccessState());
        });
  }

  Future<void> setGroupLastMessage({
    required String lastMessage,
    required Timestamp messageTime,
    required MessageType messageType,
  }) async {
    final result = await setGroupLastMessageUseCase.setGroupLastMessage(
        groupId:  _group!.id,
        lastMessage: lastMessage,
      lastMessageSenderId: fireStoreCubit.currentAppUser!.id,
      lastMessageSenderName: fireStoreCubit.currentAppUser!.name,
        messageTime: messageTime,
        messageType: messageType,
    );
    result.fold(
            (l) => emit(SetGroupLastMessageFailureState(l.message)),
            (r){
          emit(SetGroupLastMessageSuccessState());
        });
  }


  late List<GroupMessage> _groupMessages;
  List<GroupMessage> get groupMessages => _groupMessages;
  List<GroupMessage> getGroupMessages({required String groupId}) {
    try {
      _groupMessages = [];
      getGroupMessagesUseCase.getChatMessages(groupId: groupId).listen((groupMessages) {
        _groupMessages = groupMessages;

        emit(GetGroupMessagesSuccessState());
      });
    } on FirebaseException catch (error) {
      emit(GetGroupMessagesFailureState(error.message.toString()));
    }
    return _groupMessages;
  }

  int? _imageUploadingProgress;
  int? get imageUploadingProgress => _imageUploadingProgress;
  Future<void> sendGroupImageFileMessage({required String sentBy,}) async {
    _imageUploadingProgress = 0;
    try{
      await sendGroupMessage(
          sentBy: sentBy,
          messageText: '',
          messageType: MessageType.image,
      );
      _imageUploadingProgress = 1;
      final compressedImagePath = await FileManager.applyFfmpegCommand(
        filePath: filePickerCubit.pickedFile!.$1!.path,
        ffmpegCommand: reduceImageSizeCommandGoodQuality,
        extension: 'jpg',
      );
      _imageUploadingProgress = 2;
      final fileUrl = await fireStorageCubit.uploadFileToFireStorage(
        folder: 'images',
        file: File(compressedImagePath!),
      );
      _imageUploadingProgress = 3;
      await updateGroupMessage(
          messageId: _messageId,
          field: 'messageText',
        value: fileUrl,
      );
      _imageUploadingProgress = 4;
      await TemporaryDirectoryManager.cleanTemporaryDirectory();
      _imageUploadingProgress = 5;
      emit(SendAndUpdateGroupFileMessageSuccessState());
      _imageUploadingProgress = null;
    } on FirebaseException catch(error){
      emit(SendAndUpdateGroupFileMessageFailureState(error.toString()));
    }
  }


  late String _videoThumbnail;
  String get videoThumbnail => _videoThumbnail;
  Future<String> getVideoMessageThumbnail() async{
    _videoThumbnail = '';
    final thumbnail = await getVideoThumbnail(videoPath: filePickerCubit.pickedFile!.$1!.path);
    if(thumbnail != null){
      _videoThumbnail = thumbnail;
      emit(GetVideoMessageThumbnailState());
    }
    return _videoThumbnail;
  }

  Future<void> sendGroupVideoFileMessage({required String sentBy,}) async {
    _imageUploadingProgress = 0;
    try{
      await sendGroupMessage(
        sentBy: sentBy,
        messageText: '',
        messageType: MessageType.video,
      );
      _imageUploadingProgress = 1;
      final videoThumbnail = await fireStorageCubit.uploadFileToFireStorage(
        folder: 'images',
        file: File(_videoThumbnail),
      );
      _imageUploadingProgress = 2;

      await updateGroupMessage(
        messageId: _messageId,
        field: 'videoMessageThumbnail',
        value: videoThumbnail,
      );
      _imageUploadingProgress = 3;

      final fileUrl = await fireStorageCubit.uploadFileToFireStorage(
        folder: 'videos',
        file: File(filePickerCubit.pickedFile!.$1!.path),
      );
      /*
      final compressedVideoPath = await FileManager.applyFfmpegCommand(
        filePath: filePickerCubit.pickedFile!.$1!.path,
        ffmpegCommand: reduceVideoSizeCommand,
        extension: 'mp4',
      );

       */
      _imageUploadingProgress = 4;
      await updateGroupMessage(
        messageId: _messageId,
        field: 'messageText',
        value: fileUrl,
      );
      _imageUploadingProgress = 5;

      await TemporaryDirectoryManager.cleanTemporaryDirectory();
      emit(SendAndUpdateGroupFileMessageSuccessState());
      _imageUploadingProgress = null;
    } on FirebaseException catch(error){
      emit(SendAndUpdateGroupFileMessageFailureState(error.toString()));
    }
  }


  Future<void> sendGroupAudioFileMessage({
    required String sentBy,
    required String audioPath,
    required int voiceNoteDuration,
    required bool isVoiceNote,
  })async{
    _imageUploadingProgress = 0;
    try{
      _imageUploadingProgress = 1;
      await sendGroupMessage(
        sentBy: sentBy,
        messageText: '',
        messageType: isVoiceNote ? MessageType.voiceNote : MessageType.audio,
        voiceNoteDuration: voiceNoteDuration,
      );
      _imageUploadingProgress = 2;
      final audioUrl = await fireStorageCubit.uploadFileToFireStorage(
        folder: 'audio',
        file: File(audioPath),
      );
      _imageUploadingProgress = 3;
      await updateGroupMessage(
        messageId: _messageId,
        field: 'messageText',
        value: audioUrl,
      );
      _imageUploadingProgress = 4;

      _imageUploadingProgress = 5;
      emit(SendAndUpdateGroupFileMessageSuccessState());
      _imageUploadingProgress = null;
    } on FirebaseException catch(error){
      emit(SendAndUpdateGroupFileMessageFailureState(error.toString()));
    }
  }


  Future<void> addOrRemoveContactFromGroup({required bool isAdding,})async{
    final result = await _addOrRemoveContactFromGroupUseCase.addOrRemoveContactFromGroup(
        groupId: _group!.id,
        members: _selectedContacts,
      isAdding: isAdding,
    );
    result.fold(
            (l) => emit(AddOrRemoveContactFromGroupFailureState(l.message)),
            (r)async{
          emit(AddOrRemoveContactFromGroupSuccessState());

        });
  }


  late TextEditingController _groupMessageController;
  TextEditingController get groupMessageController => _groupMessageController;

  void initChatMessageController(){
    _groupMessageController = TextEditingController();
    emit(InitGroupChatMessageControllerState());
  }

  void clearGroupChatMessageText(){
    _groupMessageController.clear();
    emit(ClearGroupChatMessageTextState());
  }

  void disposeChatMessageController(){
    _groupMessageController.dispose();
    emit(DisposeGroupChatMessageControllerState());
  }

  Future<void> deleteGroupMessage({
    required List<String> ids,
  }) async {
    final result = await _deleteGroupMessageUseCase.deleteGroupMessage(
      groupId: _group!.id,
        ids: ids);
    result.fold(
          (l) => emit(DeleteGroupMessageFailureState(l.message)),
          (r) => emit(DeleteGroupMessageSuccessState()),);
  }

  Future<void> deleteGroup({required String id,})async{
    emit(DeleteGroupLoadingState());
    final result = await _deleteGroupUseCase.deleteGroup(id: id);
    result.fold(
            (l) => emit(DeleteGroupFailureState(l.message)),
            (r){
          emit(DeleteGroupSuccessState());
            });
  }



}
