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
                'of ${questionsController.questions.length}',
              ),
              ElevatedButton(
                onPressed: () => questionsController.saveResults(),
                child: const Text("Сохранить результат"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
