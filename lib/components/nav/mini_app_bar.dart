import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

class MiniAppBar extends BaseComponent {
  final Widget? leading;
  final Widget? title;
  final List<Widget> actions;
  final bool centerTitle;
  final double? height;

  const MiniAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions = const <Widget>[],
    this.centerTitle = false,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);
    final double barHeight = height ?? theme.spacing.xl * 2;
    final bool isGlass = theme.name == 'glass';

    final Widget row = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        leading ?? SizedBox(width: theme.spacing.lg),
        Expanded(
          child: Align(
            alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
            child: DefaultTextStyle(
              style: theme.typography.title.copyWith(
                color: theme.colors.foreground,
              ),
              child: title ?? const SizedBox.shrink(),
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: actions,
        ),
      ],
    );

    if (!isGlass) {
      return Container(
        height: barHeight,
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.lg,
        ),
        decoration: BoxDecoration(
          color: theme.colors.background,
          border: Border(
            bottom: BorderSide(
              color: theme.colors.foreground.withValues(alpha: 0.06),
            ),
          ),
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
          height: barHeight,
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.lg,
          ),
          decoration: BoxDecoration(
            color: theme.colors.background.withValues(alpha: 0.6),
            border: Border(
              bottom: BorderSide(
                color: theme.colors.foreground.withValues(alpha: 0.08),
              ),
            ),
          ),
          child: row,
        ),
      ),
    );
  }
}
