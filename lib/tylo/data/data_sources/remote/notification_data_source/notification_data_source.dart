
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:dio/dio.dart';
import 'package:tylo/tylo/core/services/shared_preference/shared_prefs_manager.dart';

class NotificationDataSource {

  late Dio dio;
  static const url = 'https://fcm.googleapis.com/v1/projects/tylo-631a6/messages:send';
  static const bearer = 'ya29.a0AcM612z3KxHtMkVQGuIskenJYEe4yv9JgetHco1w-pv7BNPWA7wvNRZ3-jw-fRqtFowkU0a0I0CN3GeqdMVP_dAGIC2pexg3pL2E8lfBNHbUeVtMENSa5-r5ubWYRxOO5N7NdX7Zy-2D2sgbnYcRK8QLaTmng6iz1ZTqJsocaCgYKAUYSARASFQHGX2MiTa6sdcShadtCzi-QM0wBBA0175';

  NotificationDataSource() {
    BaseOptions options = BaseOptions(
      baseUrl: url,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60), // 60 seconds,
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearer',
      },
    );

    dio = Dio(options,);
  }


  Future<void> sendNotification({required String token,}) async {
    try {

      final response = await dio.post(url, data: {
        'message':{
           'token': 'c9qQbrpKRIihDxJOjmeEEo:APA91bE6YwqJ6VZDY_L-Q55Q6nSTFz7-mU1hDPKD9a5NZ7S3uFXGTHF5lfwTnCE3kebN_l4M47nmdX5aVUNXb5KLxD0ar_hi4Sp2XdPx5LFZukyemko9eos',
         // 'token': 'emJvF_RQR6qQpWJ-G1T2ZR:APA91bGTv92uaNwXvHCrW68mrr24kuZ1QswvqE0qhXzIO2u5biU9Lsk6BSrxc1kgBrvnsrfOrR9TZv798_z0Bn-2vGmU6bzV_Mp5rITUCkmkhQVKmqPz5j0deoeAgYAC7xZAEcrT_laj',
          'notification' : {
            'title': 'This is title',
            'body': 'This is body'
          },
          'data': {
            'current_user_fcm_token': 'c9qQbrpKRIihDxJOjmeEEo:APA91bE6YwqJ6VZDY_L-Q55Q6nSTFz7-mU1hDPKD9a5NZ7S3uFXGTHF5lfwTnCE3kebN_l4M47nmdX5aVUNXb5KLxD0ar_hi4Sp2XdPx5LFZukyemko9eos',
            //'current_user_fcm_token': 'emJvF_RQR6qQpWJ-G1T2ZR:APA91bGTv92uaNwXvHCrW68mrr24kuZ1QswvqE0qhXzIO2u5biU9Lsk6BSrxc1kgBrvnsrfOrR9TZv798_z0Bn-2vGmU6bzV_Mp5rITUCkmkhQVKmqPz5j0deoeAgYAC7xZAEcrT_laj',
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          }
        }
      });
      print('{{{{{{{{{{{{{{{{{{{{{{{object}}}}}}}}}}}}}}}}}}}}}}} ${response.statusCode}');

      if(response.statusCode == 200){
        print('{{{{{{{{{{{{{{{{{{{{{{{object}}}}}}}}}}}}}}}}}}}}}}} ${response.data}');
        return response.data;
      }
    } catch (e) {
      return;
    }
  }
  final apiKey = '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';


  Future<String?> editImageDio({
    required String imagePath,
  }) async {
    try {
      final dio = Dio();
      // Check if it's a valid .png file
      if (!imagePath.toLowerCase().endsWith('.png')) {
        print('❌ Image must be a PNG file');
        return null;
      }

      final file = File(imagePath);
      if (!file.existsSync()) {
        print('❌ Image file not found');
        return null;
      }

      dio.options.headers['Authorization'] = 'Bearer $apiKey';

      final formData = FormData.fromMap({
        'prompt': 'Add a cat beside the child',
        'n': '1',
        'size': '512x512',
        'image': await MultipartFile.fromFile(imagePath, filename: 'image.png'),
      });

      final response = await dio.post(
        'https://api.openai.com/v1/images/edits',
        data: formData,
      );

      if (response.statusCode == 200) {
        final url = response.data['data'][0]['url'];
        print('✅ Image URL: $url');
        return url;
      } else {
        print('❌ Error: ${response.statusCode}, ${response.data}');
        return null;
      }
    } catch (e) {
      print('❗ Exception: $e');
      return null;
    }
  }

  Future<void> editImageWithOpenAI({
    required File imageFile,
  }) async {
    print('111111111111111111111111111111111111111');
    print('2222222222222222222222222222222');

    try {
      print('333333333333333333333333333333333333333');

      final response = await dio.post(
        'https://api.openai.com/v1/images/edits',
        data: {
          'prompt': 'Add a cat sitting beside the child',
          'size': '512x512',
          'image': imageFile.path,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
          },
        ),
      );
      print('response.statusCode ${response.statusCode}');

      if (response.statusCode == 200) {
        final imageUrl = response.data['data'][0]['url'];
        print('🖼️ Edited image URL: $imageUrl');
      } else {
        print('❌ Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('❗ Error occurred: $e');
    }
  }

}

