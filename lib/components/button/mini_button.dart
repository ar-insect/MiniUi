import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

enum MiniButtonVariant {
  primary,
  ghost,
  danger,
}

class MiniButton extends BaseComponent {
  final String label;
  final VoidCallback? onPressed;
  final MiniButtonVariant variant;
  final bool disabled;

  const MiniButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = MiniButtonVariant.primary,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);
    final MiniButtonColors colors = _resolveColors(theme);

    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: disabled ? null : onPressed,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: theme.radius.medium,
            border: Border.all(color: colors.border),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.lg,
              vertical: theme.spacing.sm,
            ),
            child: DefaultTextStyle(
              style: theme.typography.body.copyWith(
                color: colors.foreground,
                fontWeight: FontWeight.w500,
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  MiniButtonColors _resolveColors(MiniTheme theme) {
    switch (variant) {
      case MiniButtonVariant.primary:
        return MiniButtonColors(
          background: theme.colors.primary,
          foreground: theme.colors.background,
          border: theme.colors.primary,
        );
      case MiniButtonVariant.ghost:
        return MiniButtonColors(
          background: theme.colors.background,
          foreground: theme.colors.primary,
          border: theme.colors.primary.withOpacity(0.3),
        );
      case MiniButtonVariant.danger:
        return MiniButtonColors(
          background: theme.colors.danger,
          foreground: theme.colors.background,
          border: theme.colors.danger,
        );
    }
  }
}

class MiniButtonColors {
  final Color background;
  final Color foreground;
  final Color border;

  const MiniButtonColors({
    required this.background,
    required this.foreground,
    required this.border,
  });
}
