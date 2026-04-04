import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

class MiniListItem extends BaseComponent {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  const MiniListItem({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    final EdgeInsetsGeometry resolvedPadding = padding ??
        EdgeInsets.symmetric(
          horizontal: theme.spacing.lg,
          vertical: theme.spacing.md,
        );

    final Widget titleWidget = Text(
      title,
      style: theme.typography.body.copyWith(
        color: theme.colors.foreground,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

    final Widget? subtitleWidget = subtitle == null
        ? null
        : Text(
            subtitle!,
            style: theme.typography.small.copyWith(
              color: theme.colors.foreground.withValues(alpha: 0.6),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          );

    final List<Widget> rowChildren = <Widget>[];

    if (leading != null) {
      rowChildren.add(Padding(
        padding: EdgeInsets.only(right: theme.spacing.md),
        child: leading!,
      ));
    }

    rowChildren.add(Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          titleWidget,
          if (subtitleWidget != null) ...<Widget>[
            SizedBox(height: theme.spacing.xs),
            subtitleWidget,
          ],
        ],
      ),
    ));

    if (trailing != null) {
      rowChildren.add(Padding(
        padding: EdgeInsets.only(left: theme.spacing.md),
        child: Align(
          alignment: Alignment.centerRight,
          child: trailing!,
        ),
      ));
    }

    final Widget content = Padding(
      padding: resolvedPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: rowChildren,
      ),
    );

    if (onTap == null) {
      return content;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: content,
    );
  }
}

