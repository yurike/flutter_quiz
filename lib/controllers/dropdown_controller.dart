import 'package:get/get.dart';

abstract class DropdownController extends GetxController {
  final RxnString selected = RxnString();
  final options = [].obs;

  void getOptions();
  void setSelected(String? value) {}
}
