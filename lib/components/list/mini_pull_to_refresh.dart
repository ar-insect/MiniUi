import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:miniui_component/core/base/base_component.dart';
import 'package:miniui_component/core/localization/mini_localizations.dart';
import 'package:miniui_component/components/loading/mini_loading.dart';
import 'package:miniui_component/components/text/mini_text.dart';

class MiniPullToRefresh extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final double triggerOffset;
  final double indicatorExtent;
  final bool enabled;

  const MiniPullToRefresh({
    super.key,
    required this.child,
    required this.onRefresh,
    this.triggerOffset = 80,
    this.indicatorExtent = 56,
    this.enabled = true,
  });

  @override
  State<MiniPullToRefresh> createState() => _MiniPullToRefreshState();
}

class _MiniPullToRefreshState extends State<MiniPullToRefresh> {
  double _dragOffset = 0;
  bool _refreshing = false;

  double get _indicatorValue {
    if (widget.triggerOffset <= 0) {
      return 0;
    }
    return (_dragOffset / widget.triggerOffset).clamp(0.0, 1.0);
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (!widget.enabled || _refreshing) {
      return false;
    }
    if (notification.metrics.axis != Axis.vertical) {
      return false;
    }

    final ScrollMetrics metrics = notification.metrics;

    if (metrics.extentBefore == 0 &&
        notification is ScrollUpdateNotification) {
      final double offset = -metrics.pixels;
      if (offset > 0) {
        setState(() {
          _dragOffset = offset.clamp(0.0, 200.0);
        });
      }
    } else if (notification is ScrollEndNotification) {
      if (_indicatorValue >= 1.0) {
        _startRefresh();
      } else if (_dragOffset != 0) {
        setState(() {
          _dragOffset = 0;
        });
      }
    }
    return false;
  }

  Future<void> _startRefresh() async {
    if (_refreshing) {
      return;
    }
    setState(() {
      _refreshing = true;
      _dragOffset = widget.indicatorExtent;
    });
    try {
      await widget.onRefresh();
    } finally {
      if (mounted) {
        setState(() {
          _refreshing = false;
          _dragOffset = 0;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);
    final MiniLocalizations i18n = MiniLocalizations.of(context);
    final double extent = widget.indicatorExtent * _indicatorValue;

    Widget? indicator;
    if (_refreshing) {
      indicator = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          MiniLoading(
            size: theme.spacing.lg,
          ),
          SizedBox(width: theme.spacing.xs),
          MiniText(
            i18n.refreshing,
            style: theme.typography.small.copyWith(
              color: theme.colors.foreground.withValues(alpha: 0.7),
            ),
          ),
        ],
      );
    } else if (extent > 0) {
      final double angle = _indicatorValue * math.pi;
      final String text = _indicatorValue >= 1.0
          ? i18n.releaseToRefresh
          : i18n.pullToRefresh;

      indicator = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Transform.rotate(
            angle: angle,
            child: MiniText(
              '↓',
              style: theme.typography.small.copyWith(
                color: theme.colors.foreground.withValues(alpha: 0.7),
              ),
            ),
          ),
          SizedBox(width: theme.spacing.xs),
          MiniText(
            text,
            style: theme.typography.small.copyWith(
              color: theme.colors.foreground.withValues(alpha: 0.7),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: extent,
          child: extent > 0
              ? Center(
                  child: indicator,
                )
              : null,
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
