import 'package:flutter_test/flutter_test.dart';
import 'package:miniui/core/base/base_component.dart';
import 'package:miniui/main.dart';

void main() {
  testWidgets('MiniUi renders with initial theme', (WidgetTester tester) async {
    final MiniThemeController controller = MiniThemeController();

    await tester.pumpWidget(MiniUiApp(controller: controller));

    expect(find.text('MiniUi'), findsOneWidget);
    expect(find.text(controller.theme.name), findsWidgets);
  });
}

