import 'package:flutter/widgets.dart';
import 'package:miniui/miniui.dart';

void main() {
  final MiniThemeController controller = MiniThemeController();
  runApp(MiniUiExampleApp(controller: controller));
}

class MiniUiExampleApp extends StatefulWidget {
  final MiniThemeController controller;

  const MiniUiExampleApp({
    super.key,
    required this.controller,
  });

  @override
  State<MiniUiExampleApp> createState() => _MiniUiExampleAppState();
}

class _MiniUiExampleAppState extends State<MiniUiExampleApp> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleThemeChanged);
  }

  @override
  void didUpdateWidget(covariant MiniUiExampleApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_handleThemeChanged);
      widget.controller.addListener(_handleThemeChanged);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleThemeChanged);
    super.dispose();
  }

  void _handleThemeChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = widget.controller.theme;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: MiniThemeProvider(
        theme: theme,
        child: WidgetsApp(
          color: theme.colors.background,
          debugShowCheckedModeBanner: false,
          builder: (context, _) {
            return Center(
              child: MiniButton(
                label: 'Hello MiniUi',
                onPressed: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}

