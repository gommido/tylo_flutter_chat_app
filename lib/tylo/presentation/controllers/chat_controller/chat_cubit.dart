import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gal/gal.dart';
import 'package:path/path.dart' as path;
import 'package:agora_uikit/agora_uikit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tylo/tylo/core/helper_functions/get_video_thumbnail.dart';
import 'package:tylo/tylo/core/shared/temporary_directory_manager.dart';
import 'package:tylo/tylo/core/utils/file_manager/file_manager.dart';
import 'package:tylo/tylo/domain/use_cases/chat/delete_chat_last_messages_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/chat/get_unseen_messages_count_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/chat/update_last_message_typing_status_use_case.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';
import 'package:tylo/tylo/domain/entities/chat_message.dart';
import 'package:tylo/tylo/domain/entities/last_message.dart';
import 'package:tylo/tylo/domain/use_cases/chat/get_my_chats_last_messages_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/chat/send_message_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/chat/set_last_message_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/chat/update_message_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/chat/update_user_typing_status_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/chat/update_unseen_last_message_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/chat/update_unseen_message_use_case.dart';
import 'package:tylo/tylo/presentation/controllers/file_picker_controller/file_picker_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/firestorage_controller/firestorage_cubit.dart';
import 'package:path_provider/path_provider.dart';
import '../../../core/services/shared_preference/shared_prefs_manager.dart';
import '../../../core/shared/uuid_manager.dart';
import '../../../core/utils/file_manager/ffmpeg_commands.dart';
import '../../../core/utils/message_type_enum.dart';
import '../../../core/utils/permission_manager.dart';
import '../../../domain/use_cases/chat/delete_chat_use_case.dart';
import '../../../domain/use_cases/chat/delete_message_use_case.dart';
import '../../../domain/use_cases/chat/get_chat_messages_use_case.dart';
import '../../../domain/use_cases/chat/get_unseen_new_chats_count_use_case.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(
      this.sendMessageUseCase,
      this.getChatMessagesUseCase,
      this.setLastMessageUseCase,
      this.getMyChatsLastMessagesUseCase,
      this._updateUserTypingStatusUseCase,
      this.updateUnSeenMessageUseCase,
      this.updateUnSeenLastMessageUseCase,
      this.fireStorageCubit,
      this._fireStoreCubit,
      this.filePickerCubit,
      this._updateMessageUseCase,
      this._deleteMessageUseCase,
      this._getUnseenMessagesCountUseCase,
      this._getUnseenNewChatsCountUseCase,
      this._updateLastMessageTypingStatusUseCase,
      this._deleteChatUseCase,
      this._deleteChatLastMessagesUseCase,
      ) : super(ChatInitial()){

    _lastMessages = [];
    _selectedItems = <String>[];
    _otherChatUserId = '';

  }

  final SendMessageUseCase sendMessageUseCase;
  final GetChatMessagesUseCase getChatMessagesUseCase;
  final GetUnseenMessagesCountUseCase _getUnseenMessagesCountUseCase;
  final SetLastMessageUseCase setLastMessageUseCase;
  final GetMyChatsLastMessagesUseCase getMyChatsLastMessagesUseCase;
  final UpdateUserTypingStatusUseCase _updateUserTypingStatusUseCase;
  final UpdateLastMessageTypingStatusUseCase _updateLastMessageTypingStatusUseCase;
  final UpdateUnSeenMessageUseCase updateUnSeenMessageUseCase;
  final UpdateUnSeenLastMessageUseCase updateUnSeenLastMessageUseCase;
  final FireStorageCubit fireStorageCubit;
  final FireStoreCubit _fireStoreCubit;
  final FilePickerCubit filePickerCubit;
  final UpdateMessageUseCase _updateMessageUseCase;
  final DeleteMessageUseCase _deleteMessageUseCase;
  final GetUnseenNewChatsCountUseCase _getUnseenNewChatsCountUseCase;
  final DeleteChatUseCase _deleteChatUseCase;
  final DeleteChatLastMessagesUseCase _deleteChatLastMessagesUseCase;

  final List<String> _chatRoomPopMenuItems =[
    'deleteChat',
    'blockContact',
  ];
  List<String> get chatRoomPopMenuItems => _chatRoomPopMenuItems;

  late TextEditingController _messageController;
  TextEditingController get messageController => _messageController;
  void initChatMessageController(){
    _messageController = TextEditingController();
  }

  void clearChatMessageText(){
    _messageController.clear();
    emit(ClearChatMessageTextState());
  }

  void disposeChatMessageController(){
    _messageController.dispose();
  }

  late ScrollController _scrollController;
  ScrollController get scrollController => _scrollController;

  void initScrollController(){
    _scrollController = ScrollController();
  }

  void scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
      emit(ScrollToBottomState());
    }
  }

  bool? isUserAtBottom;
  bool? isUserAtTop;

  void checkIfUserIsInBottom(){
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        isUserAtBottom = true;
      } else {
        isUserAtBottom = false;
      }
    } else {
      isUserAtBottom = false;
    }
    if (_scrollController.position.pixels == _scrollController.position.minScrollExtent) {
      isUserAtTop = true;
    }else{
      isUserAtTop = false;
    }

    emit(CheckIfUserIsInBottomState());
  }



  void disposeScrollController(){
    _scrollController.dispose();
    emit(DisposeScrollControllerState());
  }

  bool? _isLongPressed;
  bool? get isLongPressed => _isLongPressed;

  void pressLongTime({bool? isLongPressed,}){
    _isLongPressed = isLongPressed;
    emit(PressLongTimeState());
  }

  bool? _isSendImageIconTapped;
  bool? get isSendImageIconTapped => _isSendImageIconTapped;
  void setSendImageIconTapped({bool? isTapped,}){
    _isSendImageIconTapped = isTapped;
    emit(SetSendImageIconTappedState());
  }


  bool _isEmojiShowing = false;
  get isEmojiShowing => _isEmojiShowing;

  void toggleEmoji() {
    _isEmojiShowing = !_isEmojiShowing;
    emit(ToggleEmojiState());
  }

  late String _otherChatUserId;
  String get otherChatUserId => _otherChatUserId;

  void setOtherChatUserId(String id){
    _otherChatUserId = id;
    print(_otherChatUserId);
    emit(SetOtherChatUserIdState());
  }

  late String _messageId;
  String get messageId => _messageId;
  Future<void> sendMessage({
    required String sentBy,
    required String sentTo,
    required String messageText,
    required String receiverName,
    required String receiverImage,
    required MessageType messageType,
    required String token,
    required String secondUserPhotoVisibility,
    String? videoMessageThumbnail,
    int? voiceNoteDuration,
    String? imageLowQuality,
    int? videoCallDuration,
  }) async {
    _messageId = getUuid();
    final messageTime = Timestamp.now();
    final result = await sendMessageUseCase.sendMessage(
      sentTo: sentTo,
      messageText: messageText,
      sentBy: sentBy,
      messageId: _messageId,
      messageType: messageType,
      messageTime: messageTime,
      token: token,
      videoMessageThumbnail: videoMessageThumbnail,
      voiceNoteDuration: voiceNoteDuration,
      imageLowQuality: imageLowQuality,
      videoCallDuration: videoCallDuration
    );
    result.fold(
            (l) => emit(SendMessageFailureState(l.message)),
            (r){
              setLastMessage(
                sentBy: sentBy,
            secondUserId: sentTo,
            secondUserName: receiverName,
            secondUserImage: receiverImage,
            lastMessage: messageText,
            messageType: messageType,
            messageTime: messageTime,
                secondUserPhotoVisibility: secondUserPhotoVisibility,
          ).then((value){});
              emit(SendMessageSuccessState());
        });
  }


  Future<void> setLastMessage({
    required String sentBy,
    required String secondUserId,
    required String secondUserName,
    required String secondUserImage,
    required String lastMessage,
    required Timestamp messageTime,
    required MessageType messageType,
    required String secondUserPhotoVisibility,
  }) async {
    final result = await setLastMessageUseCase.setLastMessage(
      firstUserName: _fireStoreCubit.currentAppUser!.name,
      firstUserImage: _fireStoreCubit.currentAppUser!.photo,
      sentBy: sentBy,
      secondUserName: secondUserName,
      secondUserImage: secondUserImage,
      secondUserId: secondUserId,
      lastMessage: lastMessage,
      messageTime: messageTime,
      messageType: messageType,
      firstUserPhotoVisibility: _fireStoreCubit.currentAppUser!.photoVisibility,
      secondUserPhotoVisibility: secondUserPhotoVisibility,
    );
    result.fold(
          (l) => emit(SendMessageFailureState(l.message)),
          (r){
            emit(SendMessageSuccessState());
          });
  }


  late List<ChatMessage> _chatMessages;
  List<ChatMessage> get chatMessages => _chatMessages;

  void clearChatMessages(){
    _chatMessages.clear();
  }


  List<ChatMessage> getChatMessages({required String sentBy,}) {
    try {
      _chatMessages = [];
      getChatMessagesUseCase.getChatMessages(
        sentBy: sentBy,
        sentTo: _otherChatUserId,
      ).listen((chatMessageList) {
        /*
        if(endIndex == null){
          _chatMessages.addAll(chatMessageList.reversed);
        }else{
          _chatMessages.insertAll(0, chatMessageList.reversed);
        }
        if (_chatMessages.isNotEmpty) {
          final offset = _scrollController.position.pixels + _chatMessages.length * 50.0;
          _scrollController.jumpTo(offset);
        }
         */
        _chatMessages = chatMessageList;
        emit(GetChatMessagesSuccessState());

      });
    } on FirebaseException catch (error) {
      emit(GetChatMessagesFailureState(error.message.toString()));
    }
    return _chatMessages;
  }

  int unSeenMessagesCount = 0;
  int getUnSeenMessagesCount({
    required String senderId,
  }) {
    try {
      unSeenMessagesCount = 0;
      _getUnseenMessagesCountUseCase.getUnSeenMessagesCount(
        senderId: senderId,
        receiverId: _otherChatUserId,
      ).listen((messages){
        unSeenMessagesCount = messages.length;
        emit(GetUnSeenMessagesCountSuccessState());
      });
    } on FirebaseException catch (error) {
      emit(GetUnSeenMessagesCountFailureState(error.message.toString()));
    }
    return unSeenMessagesCount;
  }


  int unSeenNewChatsCount = 0;
  int getUnSeenNewChatsCount({required String id}) {
    try {
      _getUnseenNewChatsCountUseCase.getUnSeenNewChatsCount(
        userId: id,
      ).listen((messages){
        unSeenNewChatsCount = messages.length;
        emit(GetUnSeenNewChatsCountSuccessState());
      });
    } on FirebaseException catch (error) {
      emit(GetUnSeenNewChatsCountFailureState(error.message.toString()));
    }
    return unSeenNewChatsCount;
  }

  late List<LastMessage> _lastMessages;
  List<LastMessage> get lastMessages => _lastMessages;
  List<LastMessage> getMyChatsLastMessages({required String id}) {
    try {
      getMyChatsLastMessagesUseCase.getMyChatsLastMessages(
        userId: id,
      ).listen((chatsLastMessages) {
        _lastMessages = chatsLastMessages;
        emit(GetMyChatsLastMessagesSuccessState());
      });

    } on FirebaseException catch (error) {
      emit(GetMyChatsLastMessagesFailureState(error.message.toString()));
    }
    return _lastMessages;
  }


  Future<void> updateUnSeenMessages({
    required String sentBy,
    required String sentTo,
  }) async {
    final result = await updateUnSeenMessageUseCase.updateUnSeenMessages(
      sentBy: sentBy,
      sentTo: sentTo,
      secondUserId: sentTo,
    );
    result.fold(
          (l) => emit(UpdateUnSeenMessageFailureState(l.message)),
          (r) => emit(UpdateUnSeenMessageSuccessState()),
    );
  }


  Future<void> updateUnSeenLastMessage({
    required String sentBy,
  }) async {
    final result = await updateUnSeenLastMessageUseCase.updateUnSeenLastMessage(
      senderId: sentBy,
      receiverId: _otherChatUserId,
    );
    result.fold(
          (l) => emit(UpdateUnSeenLastMessageFailureState(l.message)),
          (r) => emit(UpdateUnSeenLastMessageSuccessState()),);
  }

  Future<void> updateMessage({
    required String firstUserId,
    required String secondUserId,
    required String messageId,
    required String field,
    dynamic value,
  }) async {
    final result = await _updateMessageUseCase.updateMessage(
        firstUserId: firstUserId,
        secondUserId: secondUserId,
        messageId: messageId,
        field: field,
        value: value,
    );
    result.fold(
          (l) => emit(UpdateMessageFailureState(l.message)),
          (r) => emit(UpdateMessageSuccessState()),);
  }


  int? _imageUploadingProgress;
  int? get imageUploadingProgress => _imageUploadingProgress;

  Future<void> sendImageFileMessage({
    required String sentBy,
    required String receiverId,
    required String receiverName,
    required String receiverImage,
    required String token,
    required String secondUserPhotoVisibility,
    required List<dynamic> secondUserContacts,
  })async{
    _imageUploadingProgress = 0;
    try{
      await sendMessage(
        sentBy: sentBy,
        sentTo: receiverId,
        receiverName: receiverName,
        receiverImage: receiverImage,
        messageText: '',
        messageType: MessageType.image,
        token: token,
        videoMessageThumbnail: null,
        voiceNoteDuration: null,
        imageLowQuality: null,
        secondUserPhotoVisibility: secondUserPhotoVisibility,
      );
      _imageUploadingProgress = 1;
      final compressedImagePathLowQuality = await FileManager.applyFfmpegCommand(
        filePath: filePickerCubit.pickedFile!.$1!.path,
        ffmpegCommand: reduceImageSizeCommandLowQuality,
        extension: 'png',
      );
      _imageUploadingProgress = 2;
      final fileUrlLowQuality = await fireStorageCubit.uploadFileToFireStorage(
        folder: 'images',
        file: File(compressedImagePathLowQuality!),
      );
      _imageUploadingProgress = 3;
      await updateMessage(
        firstUserId: receiverId,
        secondUserId: sentBy,
        messageId: _messageId,
        field: 'imageLowQuality',
        value : fileUrlLowQuality,
      );
      _imageUploadingProgress = 4;
      final compressedImagePathGoodQuality = await FileManager.applyFfmpegCommand(
        filePath: filePickerCubit.pickedFile!.$1!.path,
        ffmpegCommand: reduceImageSizeCommandGoodQuality,
        extension: 'png',
      );
      _imageUploadingProgress = 5;
      final fileUrlGoodQuality = await fireStorageCubit.uploadFileToFireStorage(
        folder: 'images',
        file: File(compressedImagePathGoodQuality!),
      );
      _imageUploadingProgress = 6;

      await updateMessage(
        firstUserId: receiverId,
        secondUserId: sentBy,
        messageId: _messageId,
        field: 'messageText',
        value : fileUrlGoodQuality,
      );
      _imageUploadingProgress = 7;

      await updateMessage(
        firstUserId: receiverId,
        secondUserId: sentBy,
        messageId: _messageId,
        field: 'imageLowQuality',
        value : null,
      );
      _imageUploadingProgress = 8;

      await updateMessage(
        firstUserId: sentBy,
        secondUserId: receiverId,
        messageId: _messageId,
        field: 'messageText',
        value : fileUrlGoodQuality,
      );
      _imageUploadingProgress = 9;
      await fireStorageCubit.deleteStoredFile(fileUrl: fileUrlLowQuality);
      _imageUploadingProgress = 10;

      await TemporaryDirectoryManager.cleanTemporaryDirectory();
      emit(SendAndUpdateFileMessageSuccessState());
      _imageUploadingProgress = null;
    } on FirebaseException catch(error){
      emit(SendAndUpdateFileMessageFailureState(error.toString()));
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

  Future<void> sendVideoFileMessage({
    required String sentBy,
    required String receiverId,
    required String receiverName,
    required String receiverImage,
    required String token,
    required String secondUserPhotoVisibility,
    required List<dynamic> secondUserContacts,
    String? voiceNoteDuration,

  })async{
    _imageUploadingProgress = 0;
    try{
      await sendMessage(
        sentBy: sentBy,
          sentTo: receiverId,
          receiverName: receiverName,
          receiverImage: receiverImage,
          messageText: '',
          messageType: MessageType.video,
          token: token,
        secondUserPhotoVisibility: secondUserPhotoVisibility,
        videoMessageThumbnail: null,
          voiceNoteDuration: null,
      );
      _imageUploadingProgress = 1;
      _imageUploadingProgress = 2;
      final thumbnail = await fireStorageCubit.uploadFileToFireStorage(
        folder: 'images',
        file: File(_videoThumbnail),
      );
      _imageUploadingProgress = 3;
      await updateMessage(
        firstUserId: receiverId,
        secondUserId: sentBy,
        messageId: _messageId,
        field: 'videoMessageThumbnail',
        value : thumbnail,
      );

      _imageUploadingProgress = 4;
      await updateMessage(
        firstUserId: sentBy,
        secondUserId: receiverId,
        messageId: _messageId,
        field: 'videoMessageThumbnail',
        value : thumbnail,
      );
      _imageUploadingProgress = 5;
      final fileUrl = await fireStorageCubit.uploadFileToFireStorage(
        folder: 'videos',
        file: filePickerCubit.pickedFile!.$1!,
      );
      _imageUploadingProgress = 6;

      await updateMessage(
        firstUserId: receiverId,
        secondUserId: sentBy,
        messageId: _messageId,
        field: 'messageText',
        value : fileUrl,
      );
      _imageUploadingProgress = 7;
      await updateMessage(
        firstUserId: sentBy,
        secondUserId: receiverId,
        messageId: _messageId,
        field: 'messageText',
        value : fileUrl,
      );

      _imageUploadingProgress = 8;
      await TemporaryDirectoryManager.cleanTemporaryDirectory();
      _imageUploadingProgress = 9;
      _imageUploadingProgress = null;
      emit(SendAndUpdateFileMessageSuccessState());
    } on FirebaseException catch(error){
      emit(SendAndUpdateFileMessageFailureState(error.toString()));
    }

  }


  Future<void> sendAudioFileMessage({
    required String sentBy,
    required String receiverId,
    required String receiverName,
    required String receiverImage,
    required String audioPath,
    required String token,
    required int voiceNoteDuration,
    required bool isVoiceNote,
    required String secondUserPhotoVisibility,
    required List<dynamic> secondUserContacts,
  })async{
    _imageUploadingProgress = 0;
    try{
      _imageUploadingProgress = 1;
      await sendMessage(
        sentBy: sentBy,
          sentTo: receiverId,
          receiverName: receiverName,
          receiverImage: receiverImage,
          messageText: '',
          messageType: isVoiceNote ? MessageType.voiceNote : MessageType.audio,
          token: token,
        secondUserPhotoVisibility: secondUserPhotoVisibility,
        videoMessageThumbnail: null,
          voiceNoteDuration: voiceNoteDuration,
      );

      _imageUploadingProgress = 2;
      final audioUrl = await fireStorageCubit.uploadFileToFireStorage(
        folder: 'audio',
        file: File(audioPath),
      );
      _imageUploadingProgress = 3;
      await updateMessage(
        firstUserId: receiverId,
        secondUserId: sentBy,
        messageId: _messageId,
        field: 'messageText',
        value : audioUrl,
      );
      _imageUploadingProgress = 4;
      await updateMessage(
        firstUserId: sentBy,
        secondUserId: receiverId,
        messageId: _messageId,
        field: 'messageText',
        value : audioUrl,
      );
      _imageUploadingProgress = 5;
      emit(SendVoiceNoteMessageSuccessState());
      _imageUploadingProgress = null;
    } on FirebaseException catch(error){
      emit(SendVoiceNoteMessageFailureState(error.toString()));
    }

  }



  late MessageType messageType;
  void getMessageType(MessageType messageType){
    this.messageType = messageType;
    emit(GetMessageTypeState());
  }


  bool? _isLastMessageDeleted;
  bool? get isLastMessageDeleted => _isLastMessageDeleted;

  void setLastMessageDeleteState({bool? isDeleted}){
    _isLastMessageDeleted = isDeleted;
    emit(SetLastMessageDeleteState());
  }

  Future<void> deleteMessage({
    required String firstUserId,
    required String secondUserId,
    required List<String> ids,
  }) async {
    final result = await _deleteMessageUseCase.deleteMessage(
        firstUserId: firstUserId,
        secondUserId: secondUserId,
        ids: ids);
    result.fold(
          (l) => emit(DeleteFailureStateMessage(l.message)),
          (r) => emit(DeleteMessageSuccessState()),);
  }


  bool? _isVideoPlayerScreenFitted;
  bool? get isVideoPlayerScreenFitted => _isVideoPlayerScreenFitted;

  void setVideoPlayerScreenFitState({bool? isFitted}){
    _isVideoPlayerScreenFitted = isFitted;
    emit(SetVideoPlayerScreenFitState());
  }

  bool? _isImageMessageScreenFitted;
  bool? get isImageMessageScreenFitted => _isImageMessageScreenFitted;

  void setImageMessageScreenFitState({bool? isFitted}){
    _isImageMessageScreenFitted = isFitted;
    emit(SetImageMessageScreenFitState());
  }

  late String currentSenderId;
  late String currentSenderName;
  late String currentImageMessageText;
  late Timestamp currentImageMessageTime;

  void setCurrentImageMessage({
    required String currentSenderId,
    required String currentSenderName,
    required String currentImageMessageText,
    required Timestamp currentImageMessageTime,
  }){
    this.currentSenderId = currentSenderId;
    this.currentSenderName = currentSenderName;
    this.currentImageMessageText = currentImageMessageText;
    this.currentImageMessageTime = currentImageMessageTime;
    emit(SetCurrentImageMessageIndexState());
  }

  bool? _isVoiceIconVisible;
  bool? get isVoiceIconVisible => _isVoiceIconVisible;

  void setVoiceIconVisibility({bool? isVisible}){
    _isVoiceIconVisible = isVisible;
    emit(SetVoiceIconVisibilityState());

  }

  Future<void> updateUserTypingStatus({
    required String sentBy,
    required bool isTyping,
  }) async {
    final result = await _updateUserTypingStatusUseCase.updateUserTypingStatus(
      senderId: sentBy,
      isTyping: isTyping,
    );
    result.fold(
          (l) => emit(UpdateTypingStatusFailureState(l.message)),
          (r) => emit(UpdateTypingStatusSuccessState()),
    );
  }

  Future<void> updateLastMessageTypingStatus({
    required String sentBy,
    required String receiverId,
    required bool isTyping,
}) async {
    final result = await _updateLastMessageTypingStatusUseCase.updateLastMessageTypingStatus(
      receiverId: receiverId,
      chatRoomId: sentBy,
      isTyping: isTyping,
    );
    result.fold(
          (l) => emit(UpdateLastMessageTypingStatusFailureState(l.message)),
          (r) => emit(UpdateLastMessageTypingStatusSuccessState()),
    );
  }


  Future<void> deleteChatLastMessages({
    required String userId,
    required List<String> ids,
  }) async {
    emit(DeleteChatLastMessageLoadingState());
    for(final id in ids){
      _lastMessages.removeWhere((message)=> message.secondUserId == id);
    }

    final result = await _deleteChatLastMessagesUseCase.deleteChatLastMessages(
      userId: userId,
      ids: ids,
    );
    result.fold(
          (l) => emit(DeleteChatLastMessageFailureState(l.message)),
          (r) => emit(DeleteChatLastMessageSuccessState()),);
  }

  Future<void> deleteChat({
    required String sentBy,
    required String secondUserId,
  }) async {
    emit(DeleteChatLoadingState());
    final result = await _deleteChatUseCase.deleteChat(
        firstUserId: sentBy,
        secondUserId: secondUserId,
        );
    result.fold(
          (l) => emit(DeleteChatFailureState(l.message)),
          (r) => emit(DeleteChatSuccessState()),);
  }


  late String filePath;
  Future<String> downloadAndSaveImageMessage({required String imageUrl, required String fileName,}) async {
    emit(DownloadAndSaveImageMessageLoadingState());
    filePath = '';
    PermissionManager permissionManager = PermissionManager();
    final permissionStatus = await permissionManager.getPermission(Permission.storage);

    if(permissionStatus == PermissionStatus.granted){
      Directory? appDir = await getExternalStorageDirectory();
      String directoryPath = path.join(appDir!.path, 'Tylo/images',);
      Directory directory = Directory(directoryPath);
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }
      filePath = path.join(directoryPath, '$fileName.png');
      try {
        Dio dio = Dio();
        await dio.download(imageUrl, filePath);
        await SharedPrefsManager.saveStringData(key: fileName, value: filePath);
        emit(DownloadAndSaveImageMessageSuccessState());
        return filePath;
      } catch (e) {
        emit(DownloadAndSaveImageMessageFailureState(e.toString()));
      }
    }
    return '';
  }

  bool? isImageDownloading;
  saveNetworkImage({required String imageUrl}) async {
    emit(SaveNetworkImageLoadingState());
    isImageDownloading = true;
    final imagePath = '${Directory.systemTemp.path}/${imageUrl.split('-').last}.jpg';
    await Dio().download(imageUrl,imagePath);
    await Gal.putImage(imagePath,);
    isImageDownloading = null;
      emit(SaveNetworkImageSuccessState());
  }



  late List<String> _selectedItems;
  List<String> get selectedItems => _selectedItems;
  void selectItems(String messageId){
    _selectedItems.add(messageId);
    emit(SelectMessageState());
  }

  void removeFromSelectedItems(String messageId){
    _selectedItems.remove(messageId);
    emit(SelectMessageState());
  }


  void clearSelectedItems(){
    _selectedItems.clear();
    emit(SelectMessageState());
  }



}
