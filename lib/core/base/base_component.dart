import 'package:flutter/widgets.dart';
import 'package:miniui/core/utils/tokens.dart';

export 'package:miniui/core/utils/tokens.dart';

class MiniThemeController extends ChangeNotifier {
  MiniThemeController({
    MiniTheme? initialTheme,
    List<MiniTheme>? availableThemes,
  })  : _theme = initialTheme ?? MiniThemes.light,
        _availableThemes = availableThemes ?? MiniThemes.all;

  MiniTheme _theme;
  final List<MiniTheme> _availableThemes;

  MiniTheme get theme => _theme;
  List<MiniTheme> get availableThemes => List.unmodifiable(_availableThemes);

  void setTheme(MiniTheme theme) {
    if (identical(theme, _theme)) {
      return;
    }
    _theme = theme;
    notifyListeners();
  }

  void setThemeByName(String name) {
    for (final MiniTheme theme in _availableThemes) {
      if (theme.name == name) {
        setTheme(theme);
        return;
      }
    }
  }
}

class MiniThemeProvider extends InheritedWidget {
  final MiniTheme theme;

  const MiniThemeProvider({
    super.key,
    required this.theme,
    required super.child,
  });

  static MiniTheme of(BuildContext context) {
    final MiniThemeProvider? provider =
        context.dependOnInheritedWidgetOfExactType<MiniThemeProvider>();
    assert(provider != null, 'MiniThemeProvider not found in context');
    return provider!.theme;
  }

  @override
  bool updateShouldNotify(MiniThemeProvider oldWidget) {
    return theme != oldWidget.theme;
  }
}

abstract class BaseComponent extends StatelessWidget {
  const BaseComponent({super.key});

  MiniTheme themeOf(BuildContext context) {
    return MiniThemeProvider.of(context);
  }
}
