import 'package:flutter_test/flutter_test.dart';
import 'package:play_space/main.dart';

void main() {
  testWidgets('App starts', (WidgetTester tester) async {
    await tester.pumpWidget(const PlaySpaceApp());
    expect(find.text('PlaySpace'), findsOneWidget);
  });
}
