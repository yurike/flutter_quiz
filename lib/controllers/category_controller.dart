import 'package:get/get.dart';

import 'dropdown_controller.dart';

class CategoryController extends GetxController implements DropdownController {
  @override
  final selected = RxnString();

  @override
  final options = [
    "Linux",
    "CMS",
    "Docker",
    "Code",
    "SQL",
    "DevOps",
  ].obs;

  @override
  void getOptions() async {
    // not implemented for now
  }

  @override
  void setSelected(String? value) {
    selected.value = value;
  }

  @override
  bool isSelected() {
    return selected.isNotEmpty != null && selected.isNotEmpty!;
  }
}
