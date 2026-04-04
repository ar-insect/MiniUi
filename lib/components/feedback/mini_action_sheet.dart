import 'package:flutter/widgets.dart';
import 'package:miniui/miniui.dart';

/// 操作表单项配置，描述每一行行为及是否为破坏性操作。
class MiniActionSheetAction {
  final String label;
  final VoidCallback? onPressed;
  final bool destructive;

  const MiniActionSheetAction({
    required this.label,
    this.onPressed,
    this.destructive = false,
  });
}

/// 底部弹出的操作列表组件，常用于展示一组操作选项和取消按钮。
class MiniActionSheet extends BaseComponent {
  final String? title;
  final List<MiniActionSheetAction> actions;
  final String cancelLabel;

  const MiniActionSheet({
    super.key,
    this.title,
    required this.actions,
    this.cancelLabel = '取消',
  });

  /// 以路由的方式弹出一个操作列表。
  static Future<void> show(
    BuildContext context, {
    String? title,
    required List<MiniActionSheetAction> actions,
    String cancelLabel = '取消',
  }) {
    return Navigator.of(context).push<void>(
      PageRouteBuilder<void>(
        opaque: false,
        barrierDismissible: true,
        barrierColor: const Color(0x99000000),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 1,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation),
                child: MiniActionSheet(
                  title: title,
                  actions: actions,
                  cancelLabel: cancelLabel,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    final List<Widget> children = <Widget>[];

    if (title != null && title!.isNotEmpty) {
      children.add(
        Padding(
          padding: EdgeInsets.all(theme.spacing.md),
          child: MiniText(
            title!,
            style: theme.typography.body.copyWith(
              color: theme.colors.foreground.withValues(alpha: 0.6),
            ),
          ),
        ),
      );
      children.add(const MiniDivider());
    }

    for (final MiniActionSheetAction action in actions) {
      children.add(
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.of(context).pop();
            action.onPressed?.call();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: theme.spacing.md,
              horizontal: theme.spacing.lg,
            ),
            child: MiniText(
              action.label,
              style: theme.typography.body.copyWith(
                color: action.destructive
                    ? theme.colors.danger
                    : theme.colors.foreground,
              ),
            ),
          ),
        ),
      );
      children.add(const MiniDivider());
    }

    return Padding(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              color: theme.colors.background,
              borderRadius: theme.radius.medium,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
          SizedBox(height: theme.spacing.sm),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colors.background,
                borderRadius: theme.radius.medium,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: theme.spacing.md,
                ),
                child: Center(
                  child: MiniText(
                    cancelLabel,
                    style: theme.typography.body.copyWith(
                      color: theme.colors.foreground,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

