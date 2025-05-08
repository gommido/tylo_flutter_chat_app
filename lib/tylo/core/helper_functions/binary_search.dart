
import '../../domain/entities/app_user.dart';

String binarySearchExists(List<AppUser> sortedList, String target) {
  int min = 0;
  int max = sortedList.length - 1;
  while (min <= max) {
    int mid = min + ((max - min) >> 1);
    if (sortedList[mid].phone == target) {
      return sortedList[mid].id; // Target found
    } else if (sortedList[mid].phone!.compareTo(target) < 0) {
      min = mid + 1;
    } else {
      max = mid - 1;
    }
  }
  return ''; // Target not found
}