import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:miniui_component/miniui.dart';

void main() {
  testWidgets('MiniButton renders label and responds to tap', (WidgetTester tester) async {
    bool tapped = false;

    final MiniThemeController controller = MiniThemeController();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: MiniThemeProvider(
          theme: controller.theme,
          child: WidgetsApp(
            color: controller.theme.colors.background,
            builder: (BuildContext context, Widget? _) {
              return Center(
                child: MiniButton(
                  label: 'Tap me',
                  onPressed: () {
                    tapped = true;
                  },
                ),
              );
            },
          ),
        ),
      ),
    );

    expect(find.text('Tap me'), findsOneWidget);
    await tester.tap(find.text('Tap me'));
    await tester.pump();
    expect(tapped, isTrue);
  });
}
