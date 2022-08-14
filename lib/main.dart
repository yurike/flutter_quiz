// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_quiz/firebase_options.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'views/questions_page.dart';
import 'views/results_page.dart';
import 'views/start_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
