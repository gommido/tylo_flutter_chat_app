import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';

class FireStorageDataSource{
  FireStorageDataSource(){
    _firebaseStorage = FirebaseStorage.instance;
  }

  late FirebaseStorage _firebaseStorage;
  Future<String> uploadFileToFireStorage({
    required String folder,
    required File file,
  }) async{
    try{
      Reference firebaseStorageRef =  _firebaseStorage.ref()
          .child('assets/$folder/${Uri.file(file.path).pathSegments.last}');
      UploadTask  uploadTask =  firebaseStorageRef.putFile(file);
      return await uploadTask.then((value){
        return value.ref.getDownloadURL();
      });
    } on FireBaseExceptions catch(error){
      throw FireBaseFailure(message: error.errorMessage.message);
    }
  }

  Future<void> deleteStoredFile({
    required String fileUrl,
  }) async{
    try{
      String filePath = fileUrl.split('/o/')[1].split('?')[0];
      filePath = Uri.decodeFull(filePath);
      Reference firebaseStorageRef =  _firebaseStorage.ref().child(filePath);
      await firebaseStorageRef.delete();
    } on FireBaseExceptions catch(error){
      throw FireBaseFailure(message: error.errorMessage.message);
    }
  }

}