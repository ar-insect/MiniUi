import 'package:flutter/widgets.dart';
import 'package:miniui/miniui.dart';

class MiniListDemoPage extends StatelessWidget {
  static const String routeName = '/list-demo';

  const MiniListDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);

    return Container(
      color: theme.colors.background,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(theme.spacing.lg),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: theme.spacing.sm),
                      child: MiniText(
                        '‹ 返回',
                        style: theme.typography.body.copyWith(
                          color: theme.colors.foreground,
                        ),
                      ),
                    ),
                  ),
                  MiniText(
                    '列表页示例',
                    style: theme.typography.title.copyWith(
                      color: theme.colors.foreground,
                    ),
                  ),
                ],
              ),
            ),
            const MiniDivider(),
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                separatorBuilder: (BuildContext context, int index) {
                  return const MiniDivider();
                },
                itemBuilder: (BuildContext context, int index) {
                  return MiniListItem(
                    title: '列表项 ${index + 1}',
                    subtitle:
                        '这是列表项的描述信息，用于展示 MiniListItem 的效果。',
                    trailing: const MiniTag(label: '查看'),
                    onTap: () {
                      MiniToast.show(
                        context,
                        '点击了列表项 ${index + 1}',
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

