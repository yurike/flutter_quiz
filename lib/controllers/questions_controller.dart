import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_quiz/models/question.dart';
import 'package:get/get.dart';

import 'category_controller.dart';
import 'difficulty_controller.dart';

class QuestionsController extends GetxController {
  final questions = <Question>[].obs;
  final currentQuestion = 0.obs;
  final answers = [].obs;
  var correctAnswers = 0.obs;
  final savedResult = "".obs;

  final CategoryController categoryController = Get.find();
  final DifficultyController difficultyController = Get.find();

  void saveAnswer(String answerKey) {
    final question = questions[currentQuestion.value];
    final bool correct =
        question.correct_answers['${answerKey}_correct'] == 'true';
    if (correct) correctAnswers++;
    answers.add({
      "question": question.question,
      "answer": question.answers[answerKey],
      "correct": correct,
    });
    if (currentQuestion.value == questions.length - 1) {
      Get.toNamed("/results");
    } else {
      currentQuestion.value++;
    }
  }

  void getQuestions() async {
    try {
      final Map<String, dynamic> parameters = {
        'limit': 10,
        'apiKey': 'j24WhINsXuMG7PszLmbkLHqRiXRoFnjRZrHxkwDa',
      };
      if (categoryController.isSelected()) {
        parameters["category"] = categoryController.selected.value;
      }
      if (categoryController.isSelected()) {
        parameters["difficulty"] = difficultyController.selected.value;
      }

      var response = await Dio().get(
        'https://quizapi.io/api/v1/questions',
        queryParameters: parameters,
      );
      //print(response.data);
      for (Map<String, dynamic> q in response.data) {
        questions.add(Question.fromJson(q));
      }
    } on DioError catch (e) {
      print("DioError...");
      if (e.response != null) {
        print(e.response?.data);
        //print(e.response?.headers)
        //print(e.response?.requestOptions)
      } else {
        //print(e.requestOptions);
        print(e.message);
      }
    }
  }

  void saveResults() {
    savedResult.value = 'saving...';
    final db = FirebaseFirestore.instance;
    final result = <String, dynamic>{
      "time": Timestamp.now(),
      "category": categoryController.selected.value,
      "difficulty": difficultyController.selected.value,
      "correct": correctAnswers.value,
      "incorrect": questions.length - correctAnswers.value,
    };
    db.collection("results").add(result).then((DocumentReference doc) {
      savedResult.value = "Saved with ID: ${doc.id}";
    });
  }
}
