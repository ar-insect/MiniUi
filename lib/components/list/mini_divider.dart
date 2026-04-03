import 'package:flutter/widgets.dart';
import 'package:miniui/core/base/base_component.dart';

class MiniDivider extends BaseComponent {
  final double thickness;
  final double indent;
  final double endIndent;

  const MiniDivider({
    super.key,
    this.thickness = 1,
    this.indent = 0,
    this.endIndent = 0,
  });

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = themeOf(context);

    return Padding(
      padding: EdgeInsets.only(left: indent, right: endIndent),
      child: SizedBox(
        height: thickness,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colors.foreground.withOpacity(0.06),
          ),
        ),
      ),
    );
  }
}

