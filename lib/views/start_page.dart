import 'package:flutter/material.dart';
import 'package:flutter_quiz/controllers/category_controller.dart';
import 'package:flutter_quiz/controllers/difficulty_controller.dart';
import 'package:get/get.dart';

import '../controllers/dropdown_controller.dart';

class StartPage extends StatelessWidget {
  final _categoryController = Get.put(CategoryController());
  final _difficultyController = Get.put(DifficultyController());

  StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildDropdown("Выберите категорию", _categoryController),
            buildDropdown("Выберите сложность", _difficultyController),
            ElevatedButton(
              onPressed: () => Get.toNamed("/questions"),
              child: const Text("Начать"),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDropdown(String hint, DropdownController controller) {
    return Obx(
      () => DropdownButton<String>(
        hint: Text(hint),
        onChanged: (newValue) {
          controller.setSelected(newValue);
          controller.update();
        },
        value: controller.selected.value,
        items: [
          for (var data in controller.options)
            DropdownMenuItem(
              value: data,
              child: Text(data),
            )
        ],
      ),
    );
  }
}
