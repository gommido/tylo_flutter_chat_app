import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tylo/tylo/domain/use_cases/call/delete_calls_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/call/update_call_data_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/call/update_room_data_use_case.dart';
import 'package:tylo/tylo/domain/entities/room.dart';
import 'package:tylo/tylo/domain/use_cases/call/create_room_use_case.dart';
import 'package:tylo/tylo/domain/use_cases/call/get_call_room_use_case.dart';
import '../../../core/shared/uuid_manager.dart';
import '../../../domain/entities/call.dart';
import '../../../domain/use_cases/call/create_call_use_case.dart';
import '../../../domain/use_cases/call/delete_room_use_case.dart';
import '../../../domain/use_cases/call/get_my_calls_use_case.dart';
import '../firestore_controller/fire_store_cubit.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  CallCubit(
      this.createRoomUseCase,
      this._createCallUseCase,
      this.fireStoreCubit,
      this._getCallRoomUseCase,
      this._updateRoomDataUseCase,
      this._deleteRoomUseCase,
      this._getMyCallsUseCase,
      this._updateCallDataUseCase,
      this._deleteCallsUseCase,

      ) : super(CallInitial());
  final CreateRoomUseCase createRoomUseCase;
  final CreateCallUseCase _createCallUseCase;
  final FireStoreCubit fireStoreCubit;
  final GetCallRoomUseCase _getCallRoomUseCase;
  final UpdateRoomDataUseCase _updateRoomDataUseCase;
  final GetMyCallsUseCase _getMyCallsUseCase;
  final DeleteRoomUseCase _deleteRoomUseCase;
  final UpdateCallDataUseCase _updateCallDataUseCase;
  final DeleteCallsUseCase _deleteCallsUseCase;

  bool? _isCallMadeByMe;
  bool? get isCallMadeByMe => _isCallMadeByMe;
  void setIsCalledByMeData({bool? isCallMadeByMe}){
    _isCallMadeByMe = isCallMadeByMe;
    emit(SetIsCalledByMeDataState());
  }

  late String _roomId;
  String get roomId => _roomId;
  Future<void> createRoom({
    required String callerId,
    required String callReceiverId,
    required String callerName,
    required String callerImage,
  }) async {
    emit(CreateRoomLoadingState());
    _roomId = getUuid();
    final result = await createRoomUseCase.createRoom(
      id: _roomId,
      callReceiverId: callReceiverId,
      callerId: callerId,
      callerName: fireStoreCubit.currentAppUser!.name,
      callerImage: fireStoreCubit.currentAppUser!.photo,
    );
    result.fold(
            (l) => emit(CreateRoomFailureState(l.message)),
            (r) {
          emit(CreateRoomSuccessState());
        });
  }

  Future<void> createCall({
    required String secondUserId,
    required String secondUserName,
    required String secondUserImage,
  }) async {
    final result = await _createCallUseCase.createCall(
        id: _roomId,
        firstUserId: fireStoreCubit.currentAppUser!.id,
        firstUserName: fireStoreCubit.currentAppUser!.name,
        firstUserImage: fireStoreCubit.currentAppUser!.photo,
        secondUserId: secondUserId,
        secondUserName: secondUserName,
        secondUserImage: secondUserImage,
    );
    result.fold(
            (l) => emit(CreateCallFailureState(l.message)),
            (r) {
          emit(CreateCallSuccessState());
        });
  }

  Room? _room;
  Room? get room => _room;
  Room? getCallRoom({required String userId, required String field,}) {
    try {
      _getCallRoomUseCase.getCallRoom(userId: userId, field: field).listen((event) {
        _room =  event;
        emit(GetCallRoomSuccessState());
      });
    } on FirebaseException catch (error) {
      emit(GetCallRoomFailureState(error.message.toString()));
    }
    return room;
  }

  Room? _roomCreatedByMe;
  Room? get roomCreatedByMe => _roomCreatedByMe;
  Room? getCallRoomCreatedByMe({required String userId,}) {
    try {
      _getCallRoomUseCase.getCallRoom(userId: userId, field: 'callerId').listen((event) {
        _roomCreatedByMe =  event;
        emit(GetCallRoomCreatedByMeSuccessState());
      });
    } on FirebaseException catch (error) {
      emit(GetCallRoomCreatedByMeFailureState(error.message.toString()));
    }
    return _roomCreatedByMe;
  }

  late List<Call> _myCalls;
  List<Call> get myCalls => _myCalls;
  List<Call> getMyCalls({required String userId,})  {
    _myCalls = [];
    try{
      _getMyCallsUseCase.getMyCalls(userId: userId).listen((calls){
        _myCalls = calls;
        emit(GetMyCallsSuccessState());
      });
    }on FirebaseException catch (error) {
      emit(GetMyCallsFailureState(error.message.toString()));
    }
    return _myCalls;
  }

  Future<void> updateCallData({
    required String id,
    required String roomId,
    required String field,
    required dynamic value,
  }) async {
    final result = await _updateCallDataUseCase.updateCallData(
        id: id,
        callId: roomId,
        field: field,
      value: value
    );
    result.fold(
            (l) => emit(DeleteRoomFailureState(l.message)),
            (r) {
          emit(DeleteRoomSuccessState());
        });
  }

  Future<void> deleteRoom({required String roomId,}) async {
    final result = await _deleteRoomUseCase.deleteRoom(id: roomId);
    result.fold(
            (l) => emit(DeleteRoomFailureState(l.message)),
            (r) {
          emit(DeleteRoomSuccessState());
        });
  }
  
  Timer? timer;
  int _calDuration = 0;
  int get calDuration => _calDuration;
  void getCallDuration() {
    _calDuration = 0;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _calDuration++;
      emit(GetCallDurationState());
    });
  }

  void cancelCallDurationTiming() {
    if(timer != null){
      timer!.cancel();
      timer = null;
      _calDuration = 0;
    }
    emit(CancelCallDurationTimingState());
  }

  Future<void> updateRoomData({required String field, required dynamic value,}) async {
    final result = await _updateRoomDataUseCase.updateRoomData(
      roomId: _room!.id,
      field: field,
      value: value,
    );
    result.fold(
            (l) => emit(UpdateCallReceiverDataFailureState(l.message)),
            (r) {
              emit(UpdateCallReceiverDataSuccessState());
        });
  }

  Offset _offset = Offset.zero;
  Offset get offset => _offset;
  late Size screenSize;
  late Size containerSize;

  void initOffsetAndSizeData({required Size size}){
    screenSize = size;
    containerSize = Size(screenSize.width / 2, screenSize.height / 10);
    final initialOffset = Offset(
      (screenSize.width - containerSize.width) / 2,
      (screenSize.height - containerSize.height) / 2,
    );
    _offset = initialOffset;
    emit(InitOffsetAndSizeData());
  }

  void handlePanUpdate(DragUpdateDetails details) {
    double newDx = _offset.dx + details.delta.dx;
    double newDy = _offset.dy + details.delta.dy;
    if (newDx < 0) newDx = 0;
    if (newDx > screenSize.width - containerSize.width) newDx = screenSize.width - containerSize.width;
    if (newDy < 0) newDy = 0;
    if (newDy > screenSize.height - containerSize.height) newDy = screenSize.height - containerSize.height;
    _offset = Offset(newDx, newDy);
    emit(HandlePanUpdateState());
  }

  Future<void> onAutoCallCancel() async{
    emit(OnAutoCallCancelLoadingState());
    await Future.delayed(const Duration(seconds: 20));
    emit(OnAutoCallCancelSuccessState());
  }

  bool? _isRoomJoined;
  bool? get isRoomJoined => _isRoomJoined;

  void setIsRoomJoinedData({bool? isJoined}){
    _isRoomJoined = isJoined;
    emit(SetIsRoomJoinedDataState());
  }

  Future<void> deleteCalls({
    required String userId,
    required List<String> ids
  }) async {
    final result = await _deleteCallsUseCase.deleteCalls(userId: userId, ids: ids);
    result.fold(
            (l) => emit(DeleteCallsFailureState(l.message)),
            (r) {
          emit(DeleteCallsSuccessState());
        });
  }

}
