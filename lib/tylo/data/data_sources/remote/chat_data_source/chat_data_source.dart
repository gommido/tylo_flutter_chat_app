import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tylo/tylo/core/resources/constants/firebase_constants.dart';
import '../../../services/firestore_service.dart';

class ChatDataSource{


  final FirebaseFirestore _firebaseFirestore;

  ChatDataSource() : _firebaseFirestore = FireBaseFireStoreService().firebaseFirestore;


  Future<void> sendMessage({
    required String messageId,
    required String sentBy,
    required String sentTo,
    required String token,
    required Map<String, dynamic> message,
  })async{

    await _firebaseFirestore.collection(FireBaseConstants.users)
        .doc(sentBy)
        .collection(FireBaseConstants.chats)
        .doc(sentTo).collection(FireBaseConstants.messages)
        .doc(messageId).set(message);
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages({
    required String sentBy,
    required String sentTo,
  }){
    return _firebaseFirestore.collection(FireBaseConstants.users)
        .doc(sentBy).collection(FireBaseConstants.chats)
    .doc(sentTo).collection(FireBaseConstants.messages)
        .orderBy('messageTime',).snapshots();
  }

  /*
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages({
    required String sentBy,
    required String sentTo,
    required int startIndex,
    int? endIndex,
  }) {



    CollectionReference<Map<String, dynamic>> collectionRef = _firebaseFirestore
        .collection(FireBaseConstants.users)
        .doc(sentBy)
        .collection(FireBaseConstants.chats)
        .doc(sentTo)
        .collection(FireBaseConstants.messages);
    if(endIndex == null) return collectionRef.orderBy('messageTime', descending: true).limit(startIndex).snapshots();


    Stream<QuerySnapshot<Map<String, dynamic>>> initialQuerySnapshot =
    collectionRef.orderBy('messageTime', descending: true).limit(startIndex + endIndex).snapshots();

    return initialQuerySnapshot.asyncExpand((snapshot) {
      if (snapshot.docs.isEmpty) {
        return Stream.value(snapshot);
      }

      DocumentSnapshot startAfterDocument = snapshot.docs.last;

      return collectionRef
          .orderBy('messageTime',  descending: true)
          .startAfterDocument(startAfterDocument)
          .limit(startIndex)
          .snapshots();
    });

  }


   */

  Future<void> setLastMessage({
    required String firstUserId,
    required String secondUserId,
    required Map<String, dynamic> messageData,
  })async{

    await _firebaseFirestore.collection(FireBaseConstants.users).doc(firstUserId).collection('lastMessages')
        .doc(secondUserId).set(messageData, SetOptions(merge: true));

  }


  Stream<QuerySnapshot<Map<String, dynamic>>> getMyChatsLastMessages({required String userId}){

    return _firebaseFirestore.collection(FireBaseConstants.users).doc(userId).collection('lastMessages')
        .orderBy('messageTime', descending: true).snapshots();
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> getUnSeenMessagesCount({
    required String senderId,
    required String receiverId,
  }){
    return _firebaseFirestore.collection(FireBaseConstants.users)
        .doc(senderId).collection(FireBaseConstants.chats).doc(receiverId)
        .collection(FireBaseConstants.messages).where('sentBy', isEqualTo: receiverId).where('isSeen', isEqualTo: false).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUnSeenNewChatsCount({
    required String userId,
  }){
    return _firebaseFirestore.collection(FireBaseConstants.users)
        .doc(userId).collection('lastMessages')
       .where('sentBy', isNotEqualTo: userId)
        .where('isSeen', isEqualTo: false).snapshots();
  }

  Future<void> updateUserTypingStatus({
    required String senderId,
    required Map<String, dynamic> data,
  })async{
   return await _firebaseFirestore.collection(FireBaseConstants.users)
        .doc(senderId).update(data);
  }

  Future<void> updateLastMessageTypingStatus({
    required String receiverId,
    required String chatRoomId,
    required Map<String, dynamic> data,
  })async{
    return await _firebaseFirestore.collection(FireBaseConstants.users)
        .doc(receiverId).collection('lastMessages').doc(chatRoomId).update(data);
  }

  Future<void> updateUnSeenMessages({
    required String sentTo,
    required String sentBy,
    required String secondUserId,

  })async{
    QuerySnapshot querySnapshot =  await _firebaseFirestore.collection(FireBaseConstants.users)
        .doc(sentTo).collection(FireBaseConstants.chats).doc(sentBy).collection(FireBaseConstants.messages)
         .where('sentBy', isEqualTo: secondUserId).where('isSeen', isEqualTo: false).get();

    WriteBatch batch = _firebaseFirestore.batch();
    if (querySnapshot.docs.isEmpty) {
      return;
    }
    for (var doc in querySnapshot.docs) {
      batch.update(
          doc.reference,
          {'isSeen': true},
      );

    }
    await batch.commit();
  }

  Future<void> updateUnSeenLastMessage({
    required String senderId,
    required String receiverId,
    required Map<String, dynamic> data,
  })async{
    return await _firebaseFirestore.collection(FireBaseConstants.users).doc(receiverId).collection('lastMessages')
        .doc(senderId).update(data);
  }


  Future<void> updateMessage({
    required String firstUserId,
    required String secondUserId,
    required String messageId,
    required Map<String, dynamic> data,
  })async{
    return await _firebaseFirestore.collection(FireBaseConstants.users).doc(firstUserId)
        .collection(FireBaseConstants.chats).doc(secondUserId).collection(FireBaseConstants.messages)
        .doc(messageId).update(data);
  }

  Future<void> deleteMessage({
    required String firstUserId,
    required String secondUserId,
    required List<String> ids,
  })async{
    List<DocumentSnapshot> allDocs = [];
    final messagesCol = _firebaseFirestore.collection(FireBaseConstants.users).doc(firstUserId).collection(FireBaseConstants.chats)
        .doc(secondUserId).collection(FireBaseConstants.messages);
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


  Future<void> deleteChatLastMessages({
    required String userId,
    required List<String> ids,
  })async{
    List<DocumentSnapshot> allDocs = [];
    final messagesCol = _firebaseFirestore.collection(FireBaseConstants.users).doc(userId)
        .collection('lastMessages');
    if (ids.length > 10) {
      for (var i = 0; i < ids.length; i += 10) {
        var batchIds = ids.sublist(i, (i + 10 > ids.length) ? ids.length : i + 10);
        QuerySnapshot querySnapshot = await messagesCol.where('secondUserId', whereIn: batchIds).get();
        allDocs.addAll(querySnapshot.docs);
      }
    }else{
      QuerySnapshot querySnapshot = await messagesCol.where('secondUserId', whereIn: ids).get();
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


  Future<void> deleteChat({
    required String firstUserId,
    required String secondUserId,
  })async{
    final chatDocRef = FirebaseFirestore.instance
        .collection(FireBaseConstants.users)
        .doc(firstUserId)
        .collection(FireBaseConstants.chats)
        .doc(secondUserId);

    final subCollectionRef = chatDocRef.collection(FireBaseConstants.messages);

    final subCollectionSnapshot = await subCollectionRef.get();
    for (final doc in subCollectionSnapshot.docs) {
      await doc.reference.delete();
    }

    await chatDocRef.delete();
  }






}