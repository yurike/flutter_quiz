import 'package:get/get.dart';

abstract class DropdownController extends GetxController {
  final selected = RxnString();
  final options = [].obs;

  ///to get options from server
  void getOptions();
  void setSelected(String? value);
  bool isSelected();
}
