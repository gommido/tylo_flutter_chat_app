import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tylo/tylo/core/resources/constants/firebase_constants.dart';
import '../../../services/firestore_service.dart';

class GroupDataSource{

  final FirebaseFirestore _firebaseFirestore;

  GroupDataSource() : _firebaseFirestore = FireBaseFireStoreService().firebaseFirestore;


  Future<void> createGroup({
    required String id,
    required Map<String, dynamic> groupData,
  })async{
    return await _firebaseFirestore.collection(FireBaseConstants.groups).doc(id).set(groupData);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getGroupDetails({
    required String id,
  }){
    return  _firebaseFirestore.collection(FireBaseConstants.groups).doc(id).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMyGroups({required String id}){
    return _firebaseFirestore.collection(FireBaseConstants.groups)
        .where('membersIds', arrayContains: id)
        .orderBy('lastMessageTime', descending: true).snapshots();
  }

  Future<void> sendGroupMessage({
    required String groupId,
    required String messageId,
    required Map<String, dynamic> message,
  })async{

    await _firebaseFirestore.collection(FireBaseConstants.groups)
        .doc(groupId)
        .collection(FireBaseConstants.messages)
        .doc(messageId).set(message);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getGroupMessages({required String groupId,}){
    return _firebaseFirestore.collection(FireBaseConstants.groups).doc(groupId)
        .collection(FireBaseConstants.messages).orderBy('messageTime').snapshots();
  }

  Future<void> setGroupLastMessage({
    required String groupId,
    required Map<String, dynamic> message,

  })async{
    return await _firebaseFirestore.collection(FireBaseConstants.groups).doc(groupId).update(message);
  }

  Future<void> updateGroupMessage({
    required String groupId,
    required String messageId,
    required Map<String, dynamic> message,
  })async{

    await _firebaseFirestore.collection(FireBaseConstants.groups)
        .doc(groupId)
        .collection(FireBaseConstants.messages)
        .doc(messageId).update(message);
  }

  Future<void> addOrRemoveContactFromGroupUseCase({
    required String groupId,
    required Map<String, dynamic> groupMember,
  })async{
    return await _firebaseFirestore.collection(FireBaseConstants.groups).doc(groupId).update(groupMember);
  }

  Future<void> removeContactFromGroup({
    required String groupId,
    required Map<String, dynamic> groupMember,
  })async{
    return await _firebaseFirestore.collection(FireBaseConstants.groups).doc(groupId).set(groupMember, SetOptions(merge: true));
  }

  Future<void> updateGroupData({
    required String id,
    required Map<String, dynamic> userData,
  }) async{
    await _firebaseFirestore.collection(FireBaseConstants.groups).doc(id).update(userData);
  }

  Future<void> deleteGroupMessage({
    required String groupId,
    required List<String> ids,
  })async{
    List<DocumentSnapshot> allDocs = [];
    final messagesCol = _firebaseFirestore.collection(FireBaseConstants.groups)
        .doc(groupId).collection(FireBaseConstants.messages);
    if (ids.length > 10) {
      for (var i = 0; i < ids.length; i += 10) {
        var batchIds = ids.sublist(i, (i + 10 > ids.length) ? ids.length : i + 10);
        QuerySnapshot querySnapshot = await messagesCol.where('messageId', whereIn: batchIds).get();
        allDocs.addAll(querySnapshot.docs);
      }
    }else{
      QuerySnapshot querySnapshot = await messagesCol.where('messageId', whereIn: ids).get();
      allDocs = querySnapshot.docs;
    }
    WriteBatch batch = _firebaseFirestore.batch();
    if (allDocs.isEmpty) {
      return;
    }
    for (var doc in allDocs) {
      batch.update(
        doc.reference,
        {
          'messageText': 'MessageDeleted'
        },
      );

    }
    await batch.commit();
  }


  Future<void> deleteGroup({
    required String id,
  }) async{
    await _firebaseFirestore.collection(FireBaseConstants.groups).doc(id).delete();
  }

}