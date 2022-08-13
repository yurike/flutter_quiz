import 'package:flutter/material.dart';
import 'package:flutter_quiz/controllers/category_controller.dart';
import 'package:flutter_quiz/controllers/difficulty_controller.dart';
import 'package:flutter_quiz/controllers/questions_controller.dart';
import 'package:flutter_quiz/views/questions_page.dart';
import 'package:flutter_quiz/views/results_page.dart';
import 'package:get/get.dart';

import 'controllers/dropdown_controller.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: "/",
      getPages: [
        GetPage(name: '/', page: () => StartPage()),
        GetPage(name: '/questions', page: () => QuestionsPage()),
        GetPage(name: '/results', page: () => ResultPage()),
      ],
    ),
  );
}

class StartPage extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());
  final DifficultyController difficultyController =
      Get.put(DifficultyController());

  StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildDropdown("Select category", categoryController),
            buildDropdown("Select difficulty", difficultyController),
            ElevatedButton(
              key: const Key("startButton"),
              onPressed: () => Get.toNamed("/questions"),
              child: const Text("Start Quiz"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDropdown(String hint, DropdownController controller) {
    //controller.getOptions();
    return Obx(
      () => DropdownButton<String>(
        hint: Text(hint),
        onChanged: (newValue) {
          controller.setSelected(newValue);
          controller.update();
        },
        value: controller.selected.value,
        items: [
          for (var data in controller.options.value)
            DropdownMenuItem(
              value: data,
              child: Text(data),
            )
        ],
      ),
    );
  }
}
