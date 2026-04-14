import 'package:flutter/widgets.dart';
import 'package:miniui/miniui.dart';

/// Search bar with pill-shaped background, placeholder and clear button.
class MiniSearchBar extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final String? placeholder;

  const MiniSearchBar({
    super.key,
    this.initialValue,
    this.onChanged,
    this.placeholder,
  });

  @override
  State<MiniSearchBar> createState() => _MiniSearchBarState();
}

class _MiniSearchBarState extends State<MiniSearchBar> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode();
    _focusNode.addListener(_handleChanged);
    _controller.addListener(_handleChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleChanged);
    _controller.removeListener(_handleChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);
    final MiniLocalizations i18n = MiniLocalizations.of(context);

    final String placeholderText =
        widget.placeholder ?? i18n.searchPlaceholder;
    final bool showPlaceholder =
        _controller.text.isEmpty && !_focusNode.hasFocus;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.background,
        borderRadius: theme.radius.pill,
        border: Border.all(
          color: theme.colors.foreground.withValues(alpha: 0.12),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.md,
          vertical: theme.spacing.xs,
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: theme.spacing.lg,
              height: theme.spacing.lg,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.colors.foreground.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Container(
                  width: theme.spacing.xs,
                  height: theme.spacing.xs,
                  decoration: BoxDecoration(
                    color: theme.colors.foreground.withValues(alpha: 0.6),
                    borderRadius: theme.radius.small,
                  ),
                ),
              ),
            ),
            SizedBox(width: theme.spacing.sm),
            Expanded(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  EditableText(
                    controller: _controller,
                    focusNode: _focusNode,
                    keyboardType: TextInputType.text,
                    style: theme.typography.body.copyWith(
                      color: theme.colors.foreground,
                    ),
                    cursorColor: theme.colors.primary,
                    backgroundCursorColor: theme.colors.background,
                    selectionColor:
                        theme.colors.primary.withValues(alpha: 0.2),
                    onChanged: (String value) {
                      widget.onChanged?.call(value);
                    },
                  ),
                  if (showPlaceholder)
                    IgnorePointer(
                      child: MiniText(
                        placeholderText,
                        style: theme.typography.body.copyWith(
                          color: theme.colors.foreground.withValues(
                            alpha: 0.4,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (_controller.text.isNotEmpty)
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _controller.clear();
                  widget.onChanged?.call('');
                  setState(() {});
                },
                child: Padding(
                  padding: EdgeInsets.only(left: theme.spacing.sm),
                  child: Container(
                    width: theme.spacing.md,
                    height: theme.spacing.md,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          theme.colors.foreground.withValues(alpha: 0.15),
                    ),
                    child: Center(
                      child: Container(
                        width: theme.spacing.xs,
                        height: 1.5,
                        decoration: BoxDecoration(
                          color: theme.colors.foreground
                              .withValues(alpha: 0.7),
                          borderRadius: theme.radius.small,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
