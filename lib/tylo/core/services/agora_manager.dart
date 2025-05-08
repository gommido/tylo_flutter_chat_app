/*

import 'package:dio/dio.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

class AgoraManager{
  static const url = 'https://agora-tokens-q1j9.onrender.com/rtc/';

  late Dio dio;

  AgoraManager(){

// Inside your AgoraManager constructor
    BaseOptions options = BaseOptions(
      baseUrl: 'https://islamicnringtones.000webhostapp.com/',
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 60), // 60 seconds,
      receiveTimeout: Duration(seconds: 60),
      headers: {
        "Content-Type": "application/json",
      },
    );

    dio = Dio(options);
  }

  String get appId => 'fd89561d78cb413bb87fc751e8de8ccb';

  /*
  Future<String> getRtcToken({required String channelName, required String uid}) async{
    try{
      Response response = await dio.get('/$channelName/publisher/userAccount/$uid');
      return response.data['rtcToken'];
    } catch(e){
      return '';
    }
  }

   */


  Future<void> sendNotification(String recipientPlayerId, String message) async {
    try {
      final response = await dio.post(
          '/notifications', // Adjusted the endpoint to be relative to baseUrl
          data: {
            "app_id": AppStrings.onSignalAppId, // Assuming appId is the correct OneSignal application ID
            "include_player_ids": [recipientPlayerId],
            "contents": {"en": message},
          }
      );

      if (response.statusCode == 200) {
        // Handle success
        print("Notification sent successfully");
      } else {
        // Handle failure
        print("Failed to send notification: ${response.statusCode}, ${response.statusMessage}");
      }
    } catch (e) {
      print("Error sending notification: $e");
    }
  }


  Future<void> sendNotificationMessage(String message, String deviceToken) async {
    var data = {
      'message': message,
      'deviceToken': deviceToken, // Include the device token
    };

    final response = await dio.post('flutter.php',
        data: data,
    );

    if (response.statusCode == 200) {
      print('Notification sentttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt');
    } else {
      print('Failed to send notificatioooooooooooooooooooooooooooooooooooooooooooooooooooooooooooon');
    }
  }

}

 */