// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_quiz/main.dart';
import 'package:get/get.dart';

void main() {
  setUp(() {
    //
  });

  group('Start page', () {
    testWidgets('Start button', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      expect(find.text('Начать'), findsOneWidget);
    });

    //group('DD', () {
    testWidgets('DropDowns', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      expect(
          find.byType(Obx),
          findsNWidgets(
              2)); // DropdownButton inside Obx is invisible for tests?
    });
    //});
  });

  //await tester.tap(find.byKey(const Key('startButton')));
  //await tester.pump();
}
