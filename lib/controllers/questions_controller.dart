import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_quiz/models/question.dart';
import 'package:get/get.dart';

import 'category_controller.dart';
import 'difficulty_controller.dart';

class QuestionsController extends GetxController {
  final questions = <Question>[].obs;
  final currentQuestion = 0.obs;
  final answers = [].obs;
  //final quizFinished = false.obs;
  var correctAnswers = 0.obs;

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
      //saveAnswers();
      Get.toNamed("/results");
    } else {
      currentQuestion.value++;
    }
  }

  void getQuestions() async {
    try {
      var response = await Dio().get(
        'https://quizapi.io/api/v1/questions',
        queryParameters: {
          'limit': 3,
          'apiKey': 'j24WhINsXuMG7PszLmbkLHqRiXRoFnjRZrHxkwDa',
          'category': categoryController.selected.value,
          'difficulty': difficultyController.selected.value,
        },
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
    print("Saving Results");
    // TODO implement saving to FireStorage
  }
}
