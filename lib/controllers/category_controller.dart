import 'package:get/get.dart';

import 'dropdown_controller.dart';

class CategoryController extends GetxController implements DropdownController {
  @override
  final selected = RxnString();

  @override
  final options = [
    "DevOps",
    "Linux",
    "Networking",
    "Python",
    "Cloud",
  ].obs;

  void getOptions() async {
    // try {
    //   var response = await Dio().get(
    //     'https://quizapi.io/api/v1/categories', // no such endpoint
    //     queryParameters: {
    //       'limit': 10,
    //       'apiKey': 'j24WhINsXuMG7PszLmbkLHqRiXRoFnjRZrHxkwDa'
    //     },
    //   );
    //   print(response);
    // } catch (e) {
    //   print(e);
    // }
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
