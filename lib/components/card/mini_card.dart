import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

/// 卡片容器组件，用于包裹内容并应用统一的卡片样式，支持普通与玻璃态两种风格。
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

    final Widget content = Padding(
      padding: padding == EdgeInsets.zero
          ? EdgeInsets.all(theme.spacing.md)
          : padding,
      child: child,
    );

    // 外层统一给卡片加一层轻微阴影，以贴近 iOS 16 之后的卡片视觉效果。
    return Padding(
      padding: margin,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colors.background,
          borderRadius: theme.radius.medium,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: theme.colors.foreground.withValues(alpha: 0.06),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: content,
      ),
    );
  }
}
