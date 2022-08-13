import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'dropdown_controller.dart';

class DifficultyController extends GetxController
    implements DropdownController {
  final selected = RxnString();
  final options = ["easy", "medium", "hard"].obs;

  void getOptions() async {}

  void setSelected(String? value) {
    selected.value = value;
  }

  @override
  bool isSelected() {
    return selected.isNotEmpty != null && selected.isNotEmpty!;
  }
}
