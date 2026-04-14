import 'package:flutter/widgets.dart';
import 'package:miniui_component/miniui.dart';

class MiniTabViewDemoPage extends StatefulWidget {
  static const String routeName = '/tab-view-demo';

  const MiniTabViewDemoPage({super.key});

  @override
  State<MiniTabViewDemoPage> createState() => _MiniTabViewDemoPageState();
}

class _MiniTabViewDemoPageState extends State<MiniTabViewDemoPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleTabTap(int index) {
    if (_currentIndex == index) {
      return;
    }
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
    );
  }

  void _handlePageChanged(int index) {
    if (_currentIndex == index) {
      return;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);
    final MiniLocalizations i18n = MiniLocalizations.of(context);

    return MiniPageScaffold(
      appBar: MiniAppBar(
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).pop(),
          child: SizedBox(
            width: theme.spacing.lg * 1.8,
            height: theme.spacing.lg * 1.8,
            child: Center(
              child: MiniText(
                '‹',
                style: theme.typography.title.copyWith(
                  fontSize: 20,
                  color: theme.colors.foreground,
                ),
              ),
            ),
          ),
        ),
        title: MiniText(i18n.tabViewTitle),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(
              theme.spacing.lg,
              theme.spacing.lg * 1.5,
              theme.spacing.lg,
              theme.spacing.lg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                MiniText(
                  'Large title',
                  style: theme.typography.heading.copyWith(
                    fontSize: 28,
                    color: theme.colors.foreground,
                  ),
                ),
                SizedBox(height: theme.spacing.xs),
                MiniText(
                  'This is an iOS-like large title area above the tab bar.',
                  style: theme.typography.small.copyWith(
                    color: theme.colors.foreground.withValues(
                      alpha: 0.7,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: theme.spacing.lg),
            child: MiniCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  MiniText(
                    'Nested header',
                    style: theme.typography.title.copyWith(
                      color: theme.colors.foreground,
                    ),
                  ),
                  SizedBox(height: theme.spacing.xs),
                  MiniText(
                    'Tabs below are driven by MiniTabBar and PageView.',
                    style: theme.typography.small.copyWith(
                      color: theme.colors.foreground.withValues(
                        alpha: 0.7,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          MiniTabBar(
            items: const <MiniTabItem>[
              MiniTabItem(label: 'Overview'),
              MiniTabItem(label: 'Details'),
              MiniTabItem(label: 'Profile'),
            ],
            currentIndex: _currentIndex,
            onTap: _handleTabTap,
            isBottom: false,
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _handlePageChanged,
              children: <Widget>[
                _buildOverviewPage(theme),
                _buildDetailsPage(theme),
                _buildProfilePage(theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewPage(MiniTheme theme) {
    return Container(
      color: theme.colors.background,
      child: ListView(
        padding: EdgeInsets.all(theme.spacing.lg),
        children: <Widget>[
          MiniCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                MiniText(
                  'Overview',
                  style: theme.typography.title.copyWith(
                    color: theme.colors.foreground,
                  ),
                ),
                SizedBox(height: theme.spacing.sm),
                MiniText(
                  'Use this tab for a high-level summary of the current '
                  'screen, such as stats or key actions.',
                  style: theme.typography.body.copyWith(
                    color: theme.colors.foreground.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: theme.spacing.lg),
          MiniCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const MiniText('Quick actions'),
                SizedBox(height: theme.spacing.sm),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: MiniButton(
                        label: 'Primary',
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: theme.spacing.sm),
                    Expanded(
                      child: MiniButton(
                        label: 'Secondary',
                        variant: MiniButtonVariant.ghost,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsPage(MiniTheme theme) {
    return Container(
      color: theme.colors.background,
      child: Center(
        child: MiniText(
          'Details content',
          style: theme.typography.title.copyWith(
            color: theme.colors.foreground,
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePage(MiniTheme theme) {
    return Container(
      color: theme.colors.background,
      child: ListView(
        padding: EdgeInsets.all(theme.spacing.lg),
        children: <Widget>[
          Row(
            children: <Widget>[
              const MiniAvatar(
                text: 'A',
                size: 48,
              ),
              SizedBox(width: theme.spacing.lg),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MiniText(
                    'Alex Doe',
                    style: theme.typography.title.copyWith(
                      color: theme.colors.foreground,
                    ),
                  ),
                  SizedBox(height: theme.spacing.xs),
                  MiniText(
                    'Product designer',
                    style: theme.typography.small.copyWith(
                      color: theme.colors.foreground.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: theme.spacing.lg),
          MiniCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const <Widget>[
                MiniListItem(
                  title: 'Account',
                  subtitle: 'Email, phone, password',
                  showArrow: true,
                ),
                MiniDivider(),
                MiniListItem(
                  title: 'Notifications',
                  subtitle: 'Push, email, marketing',
                  showArrow: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
