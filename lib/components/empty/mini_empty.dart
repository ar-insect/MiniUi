import 'package:flutter/widgets.dart';
import 'package:miniui_component/miniui.dart';

/// Empty-state component used when there is no data to show.
class MiniEmpty extends BaseComponent {
  final String? message;
  final Widget? icon;

  const MiniEmpty({
    super.key,
    this.message,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);
    final MiniLocalizations i18n = MiniLocalizations.of(context);

    final String resolvedMessage = message ?? i18n.emptyMessage;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          icon ??
              SizedBox(
                width: theme.spacing.xl * 2,
                height: theme.spacing.xl * 2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: theme.radius.large,
                    border: Border.all(
                      color: theme.colors.foreground.withValues(alpha: 0.08),
                    ),
                    color: theme.colors.background,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: theme.spacing.lg * 1.6,
                          height: theme.spacing.md,
                          decoration: BoxDecoration(
                            borderRadius: theme.radius.small,
                            border: Border.all(
                              color: theme.colors.foreground
                                  .withValues(alpha: 0.15),
                            ),
                          ),
                        ),
                        SizedBox(height: theme.spacing.xs),
                        Container(
                          width: theme.spacing.lg,
                          height: 2,
                          color:
                              theme.colors.foreground.withValues(alpha: 0.12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          SizedBox(height: theme.spacing.md),
          DefaultTextStyle(
            style: theme.typography.body.copyWith(
              color: theme.colors.foreground.withValues(alpha: 0.6),
            ),
            child: Text(resolvedMessage),
          ),
        ],
      ),
    );
  }
}
