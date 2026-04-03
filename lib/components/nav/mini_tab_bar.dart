import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:miniui/components/text/mini_text.dart';
import 'package:miniui/core/base/base_component.dart';

class MiniTabItem {
  final String label;
  final Widget? icon;

  const MiniTabItem({
    required this.label,
    this.icon,
  });
}

class MiniTabBar extends BaseComponent {
  final List<MiniTabItem> items;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final bool isBottom;

  const MiniTabBar({
    super.key,
    required this.items,
    required this.currentIndex,
    this.onTap,
    this.isBottom = true,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);
    final bool isGlass = theme.name == 'glass';

    final Widget row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        for (int i = 0; i < items.length; i++)
          _buildItem(
            context,
            theme,
            items[i],
            i,
          ),
      ],
    );

    final EdgeInsetsGeometry padding = EdgeInsets.symmetric(
      horizontal: theme.spacing.lg,
      vertical: theme.spacing.sm,
    );

    final Border border = Border(
      top: isBottom
          ? BorderSide(
              color: theme.colors.foreground.withOpacity(0.06),
            )
          : BorderSide.none,
      bottom: !isBottom
          ? BorderSide(
              color: theme.colors.foreground.withOpacity(0.06),
            )
          : BorderSide.none,
    );

    if (!isGlass) {
      return Container(
        padding: padding,
        decoration: BoxDecoration(
          color: theme.colors.background,
          border: border,
        ),
        child: row,
      );
    }

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 20,
          sigmaY: 20,
        ),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: theme.colors.background.withOpacity(0.7),
            border: border,
          ),
          child: row,
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    MiniTheme theme,
    MiniTabItem item,
    int index,
  ) {
    final bool selected = index == currentIndex;

    final Color color = selected
        ? theme.colors.primary
        : theme.colors.foreground.withOpacity(0.6);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap == null ? null : () => onTap!(index),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: theme.spacing.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (item.icon != null)
              IconTheme(
                data: IconThemeData(
                  color: color,
                  size: theme.spacing.lg,
                ),
                child: item.icon!,
              ),
            if (item.icon != null) SizedBox(height: theme.spacing.xs),
            MiniText(
              item.label,
              style: theme.typography.small.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
