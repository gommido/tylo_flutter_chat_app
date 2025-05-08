import 'package:fluttertoast/fluttertoast.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';

class CustomToast {
  static void show({
    required String title,
    Toast toastLength = Toast.LENGTH_SHORT,
    bool? isCenter,
  }) {
    Fluttertoast.showToast(
        msg: title,
        toastLength: toastLength,
        gravity: isCenter == null ? ToastGravity.BOTTOM : ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: ColorManager.white,
        textColor: ColorManager.black,
        fontSize: FontManager.s12,
    );
  }
}
