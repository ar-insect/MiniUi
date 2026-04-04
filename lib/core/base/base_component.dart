import 'package:flutter/widgets.dart';
import 'package:miniui/core/utils/tokens.dart';

export 'package:miniui/core/utils/tokens.dart';

/// 主题控制器，负责保存当前主题并对外提供切换能力。
class MiniThemeController extends ChangeNotifier {
  MiniThemeController({
    MiniTheme? initialTheme,
    List<MiniTheme>? availableThemes,
  })  : _theme = initialTheme ?? MiniThemes.light,
        _availableThemes = availableThemes ?? MiniThemes.all;

  MiniTheme _theme;
  final List<MiniTheme> _availableThemes;

  /// 当前生效的主题。
  MiniTheme get theme => _theme;

  /// 当前可选的全部主题列表。
  List<MiniTheme> get availableThemes => List.unmodifiable(_availableThemes);

  /// 直接设置主题实例并通知所有监听者。
  void setTheme(MiniTheme theme) {
    if (identical(theme, _theme)) {
      return;
    }
    _theme = theme;
    notifyListeners();
  }

  /// 根据主题名称在可选主题中查找并切换主题。
  void setThemeByName(String name) {
    for (final MiniTheme theme in _availableThemes) {
      if (theme.name == name) {
        setTheme(theme);
        return;
      }
    }
  }
}

/// 将 [MiniTheme] 注入到 Widget 树中的 InheritedWidget。
class MiniThemeProvider extends InheritedWidget {
  final MiniTheme theme;

  const MiniThemeProvider({
    super.key,
    required this.theme,
    required super.child,
  });

  /// 从上下文中读取当前的 [MiniTheme]。
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

/// 所有组件的基础类，提供统一的 [themeOf] 方法。
abstract class BaseComponent extends StatelessWidget {
  const BaseComponent({super.key});

  /// 从上下文中获取当前生效的主题。
  MiniTheme themeOf(BuildContext context) {
    return MiniThemeProvider.of(context);
  }
}
