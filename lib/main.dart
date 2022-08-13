import 'package:flutter/material.dart';
import 'package:flutter_quiz/views/questions_page.dart';
import 'package:flutter_quiz/views/results_page.dart';
import 'package:get/get.dart';

import 'views/start_page.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      getPages: [
        GetPage(name: '/', page: () => StartPage()),
        GetPage(name: '/questions', page: () => QuestionsPage()),
        GetPage(name: '/results', page: () => ResultPage()),
      ],
    );
  }
}
