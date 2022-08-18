import 'package:get/get.dart';
import 'dropdown_controller.dart';

class DifficultyController extends GetxController
    implements DropdownController {
  @override
  final selected = RxnString();
  @override
  final options = ["easy", "medium", "hard"].obs;

  @override
  void getOptions() async {}

  @override
  void setSelected(String? value) {
    selected.value = value;
  }

  @override
  bool isSelected() {
    return selected.isNotEmpty != null && selected.isNotEmpty!;
  }
}
