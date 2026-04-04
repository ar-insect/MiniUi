import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

/// 骨架屏形状类型，支持矩形和圆形两种占位形态。
enum MiniSkeletonShape {
  rect,
  circle,
}

/// 骨架屏组件，用于在数据加载中展示占位内容。
class MiniSkeleton extends BaseComponent {
  final double width;
  final double height;
  final MiniSkeletonShape shape;
  final BorderRadiusGeometry? borderRadius;

  const MiniSkeleton.rect({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  }) : shape = MiniSkeletonShape.rect;

  const MiniSkeleton.circle({
    super.key,
    required double size,
  })  : width = size,
        height = size,
        shape = MiniSkeletonShape.circle,
        borderRadius = null;

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.colors.foreground.withValues(alpha: 0.06),
        borderRadius: shape == MiniSkeletonShape.circle
            ? BorderRadius.circular(width / 2)
            : (borderRadius ?? theme.radius.small),
      ),
    );
  }
}

