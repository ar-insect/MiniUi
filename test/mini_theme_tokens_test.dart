import 'package:flutter_test/flutter_test.dart';
import 'package:miniui/core/utils/tokens.dart';

void main() {
  test('MiniThemes.light has consistent spacing tokens', () {
    final MiniTheme theme = MiniThemes.light;
    final MiniSpacingTokens spacing = theme.spacing;

    expect(spacing.xs, lessThan(spacing.sm));
    expect(spacing.sm, lessThan(spacing.md));
    expect(spacing.md, lessThan(spacing.lg));
    expect(spacing.lg, lessThan(spacing.xl));
  });

  test('MiniThemes.light and dark differ by brightness', () {
    final MiniTheme light = MiniThemes.light;
    final MiniTheme dark = MiniThemes.dark;

    expect(light.brightness, isNot(equals(dark.brightness)));
  });
}

