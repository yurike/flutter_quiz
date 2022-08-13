import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_quiz/models/question.dart';
import 'package:get/get.dart';

class QuestionsController extends GetxController {
  final questions = <Question>[].obs;
  final currentQuestion = 0.obs;
  final answers = [].obs;
  final quizFinished = false.obs;
  var correctAnswers = 0.obs;

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
      saveAnswers();
      Get.toNamed("/results");
    } else {
      currentQuestion.value++;
    }
  }

  void getQuestions(String? category, String? difficulty) async {
    try {
      var response = await Dio().get(
        'https://quizapi.io/api/v1/questions',
        queryParameters: {
          'limit': 10,
          'apiKey': 'j24WhINsXuMG7PszLmbkLHqRiXRoFnjRZrHxkwDa',
          'category': category,
          'difficulty': difficulty,
        },
      );
      //print(response.data.toString());
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

  Future<void> setFakeQuestions() async {
    await Future.delayed(const Duration(seconds: 2));
    final data = jsonDecode(fakeResultData);
    for (Map<String, dynamic> q in data) {
      questions.add(Question(
        id: q["id"],
        question: q["question"],
        description: q['description'],
        multiple_correct_answers: q["multiple_correct_answers"] == 'true',
        answers: q["answers"],
        correct_answers: q['correct_answers'],
        explanation: q['explanation'],
        category: q['category'],
        difficulty: q['difficulty'],
      ));
    }
    print("done fake");
  }

  void saveAnswers() {
    print("Save Answers");
    quizFinished.value = true;
    // TODO implement saving to FireStorage
  }

  final fakeResultData = '''[
  {
    "id": 1,
    "question": "How to delete a directory in Linux?",
    "description": "fake delete folder",
    "answers": {
      "answer_a": "ls",
      "answer_b": "delete",
      "answer_c": "remove",
      "answer_d": "rmdir",
      "answer_e": null,
      "answer_f": null
    },
    "multiple_correct_answers": "false",
    "correct_answers": {
      "answer_a_correct": "false",
      "answer_b_correct": "false",
      "answer_c_correct": "false",
      "answer_d_correct": "true",
      "answer_e_correct": "false",
      "answer_f_correct": "false"
    },
    "explanation": "rmdir deletes an empty directory",
    "tip": null,
    "tags": [],
    "category": "linux",
    "difficulty": "Easy"
  },
  {
    "id": 2,
    "question": "Another question about Linux?",
    "description": "another fake q",
    "answers": {
      "answer_a": "fake1",
      "answer_b": "fake2",
      "answer_c": "fake3 right",
      "answer_d": "fake4",
      "answer_e": "fake5",
      "answer_f": null
    },
    "multiple_correct_answers": "false",
    "correct_answers": {
      "answer_a_correct": "false",
      "answer_b_correct": "false",
      "answer_c_correct": "true",
      "answer_d_correct": "false",
      "answer_e_correct": "false",
      "answer_f_correct": "false"
    },
    "explanation": "fake explain",
    "tip": null,
    "tags": [],
    "category": "linux",
    "difficulty": "Easy"
  }
  ]''';
}
