import 'package:flutter/widgets.dart';

/// 描述一组语义化的颜色 Token，用于统一管理主题中的主色、背景色等。
class MiniColorTokens {
  final Color primary;
  final Color background;
  final Color foreground;
  final Color accent;
  final Color danger;

  const MiniColorTokens({
    required this.primary,
    required this.background,
    required this.foreground,
    required this.accent,
    required this.danger,
  });
}

/// 描述一组语义化的间距 Token，从 xs 到 xl 递增，用于统一布局间距。
class MiniSpacingTokens {
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;

  const MiniSpacingTokens({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });
}

/// 描述一组圆角 Token，用于统一组件的圆角风格。
class MiniRadiusTokens {
  final BorderRadius small;
  final BorderRadius medium;
  final BorderRadius large;
  final BorderRadius pill;

  const MiniRadiusTokens({
    required this.small,
    required this.medium,
    required this.large,
    required this.pill,
  });
}

/// 描述一组排版 Token，用于统一文字大小和字重。
class MiniTypographyTokens {
  final TextStyle body;
  final TextStyle small;
  final TextStyle title;
  final TextStyle heading;

  const MiniTypographyTokens({
    required this.body,
    required this.small,
    required this.title,
    required this.heading,
  });
}

/// 聚合颜色、间距、圆角、排版等多类 Token，构成一整套主题。
class MiniTheme {
  final String name;
  final Brightness brightness;
  final MiniColorTokens colors;
  final MiniSpacingTokens spacing;
  final MiniRadiusTokens radius;
  final MiniTypographyTokens typography;

  const MiniTheme({
    required this.name,
    required this.brightness,
    required this.colors,
    required this.spacing,
    required this.radius,
    required this.typography,
  });
}

/// 内置的一组主题工厂，提供默认间距/圆角/排版和多套配色方案。
class MiniThemes {
  static const MiniSpacingTokens defaultSpacing = MiniSpacingTokens(
    xs: 4,
    sm: 10,
    md: 14,
    lg: 20,
    xl: 28,
  );

  static const MiniRadiusTokens defaultRadius = MiniRadiusTokens(
    small: BorderRadius.all(Radius.circular(4)),
    medium: BorderRadius.all(Radius.circular(10)),
    large: BorderRadius.all(Radius.circular(16)),
    pill: BorderRadius.all(Radius.circular(999)),
  );

  static const MiniTypographyTokens defaultTypography = MiniTypographyTokens(
    body: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
    ),
    small: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w400,
    ),
    title: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    heading: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w700,
    ),
  );

  static final MiniTheme light = MiniTheme(
    name: 'light',
    brightness: Brightness.light,
    colors: const MiniColorTokens(
      primary: Color(0xFF0066FF),
      background: Color(0xFFFFFFFF),
      foreground: Color(0xFF000000),
      accent: Color(0xFF00C853),
      danger: Color(0xFFD50000),
    ),
    spacing: defaultSpacing,
    radius: defaultRadius,
    typography: defaultTypography,
  );

  static final MiniTheme dark = MiniTheme(
    name: 'dark',
    brightness: Brightness.dark,
    colors: const MiniColorTokens(
      primary: Color(0xFF82B1FF),
      background: Color(0xFF121212),
      foreground: Color(0xFFFFFFFF),
      accent: Color(0xFF00E676),
      danger: Color(0xFFFF5252),
    ),
    spacing: defaultSpacing,
    radius: defaultRadius,
    typography: defaultTypography,
  );

  static final MiniTheme blue = MiniTheme(
    name: 'blue',
    brightness: Brightness.light,
    colors: const MiniColorTokens(
      primary: Color(0xFF1565C0),
      background: Color(0xFFE3F2FD),
      foreground: Color(0xFF0D47A1),
      accent: Color(0xFF64B5F6),
      danger: Color(0xFFC62828),
    ),
    spacing: defaultSpacing,
    radius: defaultRadius,
    typography: defaultTypography,
  );

  static final MiniTheme red = MiniTheme(
    name: 'red',
    brightness: Brightness.light,
    colors: const MiniColorTokens(
      primary: Color(0xFFC62828),
      background: Color(0xFFFFEBEE),
      foreground: Color(0xFFB71C1C),
      accent: Color(0xFFEF5350),
      danger: Color(0xFFB71C1C),
    ),
    spacing: defaultSpacing,
    radius: defaultRadius,
    typography: defaultTypography,
  );

  static final MiniTheme festival = MiniTheme(
    name: 'festival',
    brightness: Brightness.light,
    colors: const MiniColorTokens(
      primary: Color(0xFFFF6D00),
      background: Color(0xFFFFF3E0),
      foreground: Color(0xFF4E342E),
      accent: Color(0xFFFFD600),
      danger: Color(0xFFD50000),
    ),
    spacing: defaultSpacing,
    radius: defaultRadius,
    typography: defaultTypography,
  );

  static final MiniTheme glass = MiniTheme(
    name: 'glass',
    brightness: Brightness.light,
    colors: const MiniColorTokens(
      primary: Color(0xFF0A84FF),
      background: Color(0xFFF2F2F7),
      foreground: Color(0xFF1C1C1E),
      accent: Color(0xFF64D2FF),
      danger: Color(0xFFFF3B30),
    ),
    spacing: defaultSpacing,
    radius: defaultRadius,
    typography: defaultTypography,
  );

  static final List<MiniTheme> all = <MiniTheme>[
    light,
    dark,
    blue,
    red,
    festival,
    glass,
  ];
}
