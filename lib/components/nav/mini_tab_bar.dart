import 'package:flutter/widgets.dart';
import 'package:miniui_component/components/text/mini_text.dart';
import 'package:miniui_component/core/base/base_component.dart';

/// Configuration for a single tab item (label + optional icon).
class MiniTabItem {
  final String label;
  final Widget? icon;

  const MiniTabItem({
    required this.label,
    this.icon,
  });
}

/// Tab bar that shows a list of equally divided navigation items at
/// the top or bottom of the screen.
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
              color: theme.colors.foreground.withValues(alpha: 0.06),
            )
          : BorderSide.none,
      bottom: !isBottom
          ? BorderSide(
              color: theme.colors.foreground.withValues(alpha: 0.06),
            )
          : BorderSide.none,
    );

    final Widget content = isBottom
        ? row
        : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              row,
              SizedBox(height: theme.spacing.xs),
              _MiniTopTabIndicator(
                itemCount: items.length,
                currentIndex: currentIndex,
                color: theme.colors.primary,
                trackColor:
                    theme.colors.foreground.withValues(alpha: 0.04),
              ),
            ],
          );

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: theme.colors.background,
        border: border,
      ),
      child: content,
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
        : theme.colors.foreground.withValues(alpha: 0.6);

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
              style: theme.typography.small.copyWith(
                color: color,
                fontWeight:
                    selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniTopTabIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final Color color;
  final Color trackColor;

  const _MiniTopTabIndicator({
    required this.itemCount,
    required this.currentIndex,
    required this.color,
    required this.trackColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double totalWidth = constraints.maxWidth;
        if (itemCount <= 0 || totalWidth <= 0) {
          return const SizedBox.shrink();
        }
        final double tabWidth = totalWidth / itemCount;
        final double indicatorWidth = tabWidth * 0.5;
        final double left =
            tabWidth * currentIndex + (tabWidth - indicatorWidth) / 2;

        return SizedBox(
          height: 3,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: ColoredBox(color: trackColor),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                left: left,
                width: indicatorWidth,
                top: 0,
                bottom: 0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
