import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

class MiniTag extends BaseComponent {
  final String label;
  final EdgeInsetsGeometry padding;

  const MiniTag({
    super.key,
    required this.label,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.accent.withOpacity(0.15),
        borderRadius: theme.radius.pill,
      ),
      child: Padding(
        padding: padding == EdgeInsets.zero
            ? EdgeInsets.symmetric(
                horizontal: theme.spacing.sm,
                vertical: theme.spacing.xs,
              )
            : padding,
        child: DefaultTextStyle(
          style: theme.typography.small
              .copyWith(color: theme.colors.accent),
          child: Text(label),
        ),
      ),
    );
  }
}
