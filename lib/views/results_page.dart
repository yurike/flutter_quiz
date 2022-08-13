import 'package:flutter/material.dart';
import 'package:flutter_quiz/controllers/questions_controller.dart';
import 'package:get/get.dart';

class ResultPage extends StatelessWidget {
  ResultPage({Key? key}) : super(key: key);

  final QuestionsController questionsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Result'),
      ),
    );
  }
}
