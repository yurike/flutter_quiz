import 'package:flutter/material.dart';
import 'package:flutter_quiz/models/question.dart';
import 'package:get/get.dart';

import '../controllers/category_controller.dart';
import '../controllers/difficulty_controller.dart';
import '../controllers/questions_controller.dart';

class QuestionsPage extends StatelessWidget {
  final CategoryController categoryController = Get.find();
  final DifficultyController difficultyController = Get.find();
  final QuestionsController questionsController =
      Get.put(QuestionsController());

  QuestionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    questionsController.getQuestions(
        categoryController.selected.value, difficultyController.selected.value);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: buildQuestion(),
        ),
      ),
    );
  }

  Widget buildQuestion() {
    return Obx(() {
      if (questionsController.questions.isEmpty) {
        return const CircularProgressIndicator();
      }
      int qIndex = questionsController.currentQuestion.value;
      Question question = questionsController.questions[qIndex];
      bool lastQuestion = (qIndex == questionsController.questions.length - 1);
      List<Widget> answerTiles = question.answers.entries.map((answer) {
        if (!(answer.value.runtimeType == Null)) {
          return RadioListTile<String>(
            title: Text(answer.value),
            value: answer.value,
            groupValue: question.question,
            onChanged: (String? value) {
              questionsController.saveAnswer(answer.key);
            },
          );
        } else {
          return const Text("");
        }
      }).toList();
      return Column(
        children: <Widget>[
          Text(
            'Question ${qIndex + 1} of ${questionsController.questions.length}',
          ),
          Text(question.question),
          const Divider(
            height: 10,
          ),
          Column(
            children: answerTiles,
          ),
        ],
      );
    });
  }
}
