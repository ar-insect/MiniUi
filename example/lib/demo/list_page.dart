import 'package:flutter/widgets.dart';
import 'package:miniui_component/miniui.dart';

class MiniListDemoPage extends StatefulWidget {
  static const String routeName = '/list-demo';

  const MiniListDemoPage({super.key});

  @override
  State<MiniListDemoPage> createState() => _MiniListDemoPageState();
}

class _MiniListDemoPageState extends State<MiniListDemoPage> {
  bool _refreshing = false;

  Future<void> _handleRefresh() async {
    if (_refreshing) {
      return;
    }
    setState(() {
      _refreshing = true;
    });
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!mounted) {
      return;
    }
    setState(() {
      _refreshing = false;
    });
    final MiniLocalizations i18n = MiniLocalizations.of(context);
    MiniToast.show(context, i18n.listRefreshDone);
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);
    final MiniLocalizations i18n = MiniLocalizations.of(context);

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
                Padding(
                  padding: EdgeInsets.only(right: theme.spacing.sm),
                  child: const MiniBackButton(),
                ),
                  MiniText(
                    i18n.listViewTitle,
                    style: theme.typography.title.copyWith(
                      color: theme.colors.foreground,
                    ),
                  ),
                ],
              ),
            ),
            const MiniDivider(),
            Expanded(
              child: MiniPullToRefresh(
                onRefresh: _handleRefresh,
                child: ListView.separated(
                  itemCount: 10,
                  separatorBuilder: (BuildContext context, int index) {
                    return const MiniDivider();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return MiniListItem(
                      title: 'Item ${index + 1}',
                      subtitle:
                          'Description text to demonstrate MiniListItem layout.',
                      trailing: const MiniTag(label: 'View'),
                      onTap: () {
                        MiniToast.show(
                          context,
                          'Tapped item ${index + 1}',
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
