import 'package:flutter/material.dart';
import 'package:flutter_quiz/controllers/questions_controller.dart';
import 'package:get/get.dart';

class ResultPage extends StatelessWidget {
  ResultPage({Key? key}) : super(key: key);

  final QuestionsController questionsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Результат",
                style: TextStyle(fontSize: 25),
              ),
              Text(
                '${questionsController.correctAnswers} '
                'из ${questionsController.questions.length}',
              ),
              buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Obx buildButton() {
    return Obx(
      () {
        switch (questionsController.savedResult.value) {
          case '':
            return ElevatedButton(
              onPressed: () => questionsController.saveResults(),
              child: const Text("Сохранить результат"),
            );
          case 'saving...':
            return const CircularProgressIndicator();
          default:
            return Text(
                'Saved with ID: ${questionsController.savedResult.value}');
        }
      },
    );
  }
}
