import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz/models/question.dart';
import 'package:get/get.dart';

class QuizService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://quizapi.io/api/v1/';
    httpClient.defaultContentType = "json";
    httpClient.timeout = const Duration(seconds: 8);
    // httpClient.addResponseModifier((request, response) async {
    //   if (kDebugMode) {
    //     print(request.url);
    //     print(request.method);
    //     print(response.body);
    //     print(response.status.code);
    //   }
    // });
    httpClient.addRequestModifier<dynamic>((request) async {
      request.headers['apikey'] = 'j24WhINsXuMG7PszLmbkLHqRiXRoFnjRZrHxkwDa';
      if (kDebugMode) {
        print(request.url);
        print(request.method);
        print(request.decoder);
        print(request.headers);
      }
      return request;
    });

    super.onInit();
  }

  Future<List<Question>> getQuestions(
      {limit = 10, String? category, String? difficulty}) async {
    final params = {"limit": limit.toString()};
    params.addIf(category != null, "category", category!);
    params.addIf(difficulty != null, "difficulty", difficulty!);

    var res = await get("questions", headers: params);
    debugPrint("res.body: " + res.body); // TODO: null
    if (res.statusCode! < 205) {
      final questions = <Question>[];
      // for (Map<String, dynamic> q in res.body) {
      //   questions.add(Question.fromJson(q));
      // }
      return questions;
    } else {
      throw "Error Occurred";
    }
  }
}
