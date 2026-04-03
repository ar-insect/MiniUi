import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

class MiniCard extends BaseComponent {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const MiniCard({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    return Padding(
      padding: margin,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colors.background,
          borderRadius: theme.radius.medium,
          border: Border.all(
            color: theme.colors.foreground.withOpacity(0.06),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: theme.colors.foreground.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: padding == EdgeInsets.zero
              ? EdgeInsets.all(theme.spacing.md)
              : padding,
          child: child,
        ),
      ),
    );
  }
}
