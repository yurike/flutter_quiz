import 'package:flutter/material.dart';
import 'package:flutter_quiz/models/question.dart';
import 'package:get/get.dart';

import '../controllers/questions_controller.dart';

class QuestionsPage extends StatelessWidget {
  final QuestionsController controller = Get.put(QuestionsController());

  QuestionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getQuestions();

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
      if (controller.networkError.value.isNotEmpty) {
        return Text(controller.networkError.string);
      } else if (controller.questions.isEmpty) {
        return const CircularProgressIndicator();
      }
      int qIndex = controller.currentQuestion.value;
      Question question = controller.questions[qIndex];

      List<Widget> answerTiles = question.answers.entries.map((answer) {
        if (answer.value != null) {
          return RadioListTile<String>(
            title: Text(answer.value),
            value: answer.value,
            groupValue: question.question,
            onChanged: (String? value) {
              controller.saveAnswer(answer.key);
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      }).toList();

      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Question ${qIndex + 1} of ${controller.questions.length}:',
          ),
          const Divider(height: 10),
          Text(
            question.question,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Divider(height: 10),
          Column(
            children: answerTiles,
          ),
        ],
      );
    });
  }
}
