import 'package:flutter/material.dart';
import 'package:flutter_quiz/controllers/category_controller.dart';
import 'package:flutter_quiz/controllers/difficulty_controller.dart';
import 'package:flutter_quiz/controllers/settings_controlles.dart';
import 'package:get/get.dart';

import '../controllers/dropdown_controller.dart';

class StartPage extends StatelessWidget {
  final _categoryController = Get.put(CategoryController());
  final _difficultyController = Get.put(DifficultyController());
  final _settingsController = Get.put(SettingsController());
  //bool _darkMode = false;

  StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz App")),
      drawer: Drawer(
        child: Column(children: [
          Text("Options:"),
          Obx(
            () => SwitchListTile(
              title: const Text("DarkMode:"),
              value: _settingsController.darkMode.isTrue,
              onChanged: (value) {
                _settingsController.darkMode(value);
                Get.changeTheme(_settingsController.darkMode.isTrue
                    ? ThemeData.dark()
                    : ThemeData.light());
              },
            ),
          ),
        ]),
      ),
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
