import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tylo/tylo/core/resources/constants/firebase_constants.dart';
import '../../../services/firestore_service.dart';

class CallDataSource{


  final FirebaseFirestore _firebaseFirestore;

  CallDataSource() : _firebaseFirestore = FireBaseFireStoreService().firebaseFirestore;


  Future<void> createRoom({
    required String id,
    required Map<String, dynamic> call,
  })async{

    await _firebaseFirestore.collection(FireBaseConstants.rooms)
        .doc(id).set(call);
  }

  Future<void> createCall({
    required String id,
    required String firstUserId,
    required Map<String, dynamic> call,
  })async{

    await _firebaseFirestore.collection(FireBaseConstants.users)
        .doc(firstUserId).collection(FireBaseConstants.calls).doc(id).set(call);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCallRoom({
    required String userId,
    required String field,
  }){
    return _firebaseFirestore.collection(FireBaseConstants.rooms).where(field, isEqualTo: userId)
        .limit(1).snapshots();
  }




  Stream<QuerySnapshot<Map<String, dynamic>>> getMyCalls({required String userId}) {
    return _firebaseFirestore.collection(FireBaseConstants.users).doc(userId)
        .collection(FireBaseConstants.calls).orderBy('callCreated', descending: true).snapshots();
  }

  Future<void> updateRoomData({
    required String roomId,
    required String field,
    dynamic value,
  })async{

    await _firebaseFirestore.collection(FireBaseConstants.rooms).doc(roomId).update({
      field: value,
    });
  }

  Future<void> updateCallData({
    required String id,
    required String callId,
    required Map<String, dynamic> data,
  })async{
    await _firebaseFirestore.collection(FireBaseConstants.users).doc(id)
        .collection(FireBaseConstants.calls).doc(callId).update(data);
  }

  Future<void> deleteRoom({required String id,})async{
    await _firebaseFirestore.collection(FireBaseConstants.rooms).doc(id).delete();
  }


  Future<void> deleteCalls({
    required String userId,
    required List<String> ids,
  })async{
    List<DocumentSnapshot> allDocs = [];
    final messagesCol = _firebaseFirestore.collection(FireBaseConstants.users).doc(userId)
        .collection(FireBaseConstants.calls);
    if (ids.length > 10) {
      for (var i = 0; i < ids.length; i += 10) {
        var batchIds = ids.sublist(i, (i + 10 > ids.length) ? ids.length : i + 10);
        QuerySnapshot querySnapshot = await messagesCol.where('id', whereIn: batchIds).get();
        allDocs.addAll(querySnapshot.docs);
      }
    }else{
      QuerySnapshot querySnapshot = await messagesCol.where('id', whereIn: ids).get();
      allDocs = querySnapshot.docs;
    }
    WriteBatch batch = _firebaseFirestore.batch();
    if (allDocs.isEmpty) {
      return;
    }
    for (var doc in allDocs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }


}