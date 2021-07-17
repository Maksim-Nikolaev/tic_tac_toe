import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/src/init/init_app.dart';

void main() {
  testWidgets('Find Tic Tac Toe text', (WidgetTester tester) async {
    await tester.pumpWidget(InitApp());

    expect(find.text('Tic Tac Toe'), findsOneWidget);
  });
}
