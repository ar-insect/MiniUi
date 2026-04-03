# MiniUi

一个基于 Flutter `widgets` 层的超轻量 UI 组件库 Demo，用于探索：

- 完全不依赖 `material.dart`
- 多主题（浅色 / 深色 / 蓝色 / 红色 / 节日…）统一管理
- 可作为 SDK / 组件库跨项目复用
- 纯 Token 驱动的设计系统（Color / Spacing / Radius / Typography）

当前仓库同时包含组件实现与可视化 Demo 页面（Web / iOS / Android）。

---

## 功能特性概览

- 无 Material 依赖  
  - 所有入口基于 `WidgetsApp` + `Directionality`  
  - 组件只依赖 `package:flutter/widgets.dart`

- 多主题 + Token 体系  
  - `MiniTheme`：聚合 Color / Spacing / Radius / Typography 多类 Token  
  - 内置主题：`light / dark / blue / red / festival`  
  - `MiniThemeController`：全局主题状态管理，支持热切换

- 纯组件化封装  
  - 基础展示：`MiniText / MiniCard / MiniImage / MiniTag / MiniEmpty / MiniLoading`  
  - 交互输入：`MiniButton / MiniInput`  
  - 表单控件：`MiniCheckbox / MiniRadio / MiniSwitch`  
  - 列表骨架：`MiniDivider / MiniListItem`  
  - 反馈：`MiniToast`（基于 `Overlay`，无 Scaffold 依赖）

- Demo 页面  
  - 首页：主题切换 + 基础组件 + 表单示例 + 列表 & Toast 示例  
  - 列表页：全屏 `MiniListItem` 列表骨架  
  - Token 页：颜色 / 间距 / 圆角 / 字体 Token 可视化

---

## 项目结构（核心部分）

```text
lib/
  core/
    base/
      base_component.dart   # MiniThemeController / MiniThemeProvider / BaseComponent
    painters/
      loading_painter.dart  # 加载动效画笔
    utils/
      tokens.dart           # MiniTheme + Color/Spacing/Radius/Typography Tokens

  components/
    button/   mini_button.dart
    card/     mini_card.dart
    empty/    mini_empty.dart
    image/    mini_image.dart
    input/    mini_input.dart
    loading/  mini_loading.dart
    tag/      mini_tag.dart
    text/     mini_text.dart
    form/
      mini_checkbox.dart
      mini_radio.dart
      mini_switch.dart
    list/
      mini_divider.dart
      mini_list_item.dart
    feedback/
      mini_toast.dart

  demo/
    home_page.dart    # 首页 Demo
    list_page.dart    # 列表页 Demo
    tokens_page.dart  # Theme Tokens 展示页

  miniui.dart         # 对外统一导出入口（模拟 SDK 用法）
  main.dart           # main + MiniUiApp + 路由配置
```

---

## 主题与 Token 体系

### MiniTheme 与 Tokens

主题定义集中在 [`lib/core/utils/tokens.dart`](lib/core/utils/tokens.dart)：

- `MiniColorTokens`
- `MiniSpacingTokens`
- `MiniRadiusTokens`
- `MiniTypographyTokens`
- `MiniTheme`（聚合以上 Tokens）
- `MiniThemes`（内置多套主题）

示例（简化）：

```dart
class MiniTheme {
  final String name;
  final Brightness brightness;
  final MiniColorTokens colors;
  final MiniSpacingTokens spacing;
  final MiniRadiusTokens radius;
  final MiniTypographyTokens typography;
}
```

组件内部统一从 `MiniTheme` 获取设计值，例如：

- 间距：`theme.spacing.md`
- 圆角：`theme.radius.medium`
- 字体：`theme.typography.body`
- 颜色：`theme.colors.primary / background / foreground ...`

### 主题控制与注入

[`lib/core/base/base_component.dart`](lib/core/base/base_component.dart) 提供：

- `MiniThemeController`：可热切换主题（`setTheme` / `setThemeByName`）
- `MiniThemeProvider`：`InheritedWidget` 注入 `MiniTheme`
- `BaseComponent`：所有组件统一继承，可直接通过 `themeOf(context)` 拿到当前主题

使用方式（在 app 根部）：

```dart
final controller = MiniThemeController(initialTheme: MiniThemes.light);

WidgetsApp(
  color: controller.theme.colors.background,
  builder: (context, _) {
    return MiniThemeProvider(
      theme: controller.theme,
      child: YourRootWidget(),
    );
  },
);
```

---

## 组件一览

所有组件通过 [`lib/miniui.dart`](lib/miniui.dart) 对外导出：

```dart
import 'package:miniui/miniui.dart';
```

- 核心
  - `MiniTheme` / `MiniThemes`
  - `MiniThemeController` / `MiniThemeProvider`
  - `BaseComponent`

- 展示类
  - `MiniText`
  - `MiniCard`
  - `MiniImage`
  - `MiniTag`
  - `MiniEmpty`
  - `MiniLoading`

- 交互 / 表单
  - `MiniButton`（primary / ghost / danger）
  - `MiniInput`
  - `MiniCheckbox`
  - `MiniRadio<T>`
  - `MiniSwitch`

- 列表
  - `MiniDivider`
  - `MiniListItem`

- 反馈
  - `MiniToast.show(context, message)`

---

## Demo 页面说明

### 路由结构

[`lib/main.dart`](lib/main.dart) 使用 `WidgetsApp.onGenerateRoute` 管理三类页面：

- `/` → `MiniHomePage`
- `/list-demo` → `MiniListDemoPage`
- `/tokens` → `MiniTokensPage`

### MiniHomePage

入口文件：[`lib/demo/home_page.dart`](lib/demo/home_page.dart)

包含：

- 主题卡片：展示当前主题名称 + 主题切换按钮（light/dark/blue/red/festival）
- 基础组件示例：输入框 / Button / Tag / Loading
- 表单示例：`MiniCheckbox + MiniRadio + MiniSwitch`
- 列表与 Toast 示例：
  - `MiniListItem + MiniDivider`
  - 点击列表项或按钮时，通过 `MiniToast.show` 弹出提示
  - 提供入口按钮跳转到「列表页示例」和「主题 Tokens 示例」

### MiniListDemoPage

入口文件：[`lib/demo/list_page.dart`](lib/demo/list_page.dart)

- 显示一组 `MiniListItem` + `MiniDivider` 构成的完整列表页骨架  
- 顶部有返回区域（`‹ 返回`），点击 `Navigator.pop()` 回首页  
- 点击任意列表项，底部弹出 `MiniToast` 提示

### MiniTokensPage

入口文件：[`lib/demo/tokens_page.dart`](lib/demo/tokens_page.dart)

- Colors：展示当前主题的一组颜色 Token 色块  
- Spacing：展示 xs–xl 对应的数值和高度对比  
- Radius：展示 small / medium / large / pill 不同圆角盒子  
- Typography：展示 heading / title / body / small 四种文字样式

---

## 开发与调试

项目根目录下提供了一组脚本（仅在 macOS 上验证）：

```bash
tools/dev_web.sh      # Web 端调试（Chrome）
tools/dev_ios.sh      # iOS 调试
tools/dev_android.sh  # Android 调试
```

使用示例：

```bash
sh tools/dev_web.sh
```

运行后可在终端使用：

- `r`：热重载（Hot Reload）
- `R`：热重启（Hot Restart）

前提：

- 已安装对应平台的开发环境（Chrome / Xcode / Android SDK）
- Flutter 已启用 Web：`flutter config --enable-web`

---

## 在其他项目中作为 SDK 使用（示例）

假设本库作为 package 引入后，可以这样集成：

```dart
import 'package:flutter/widgets.dart';
import 'package:miniui/miniui.dart';

void main() {
  final controller = MiniThemeController(initialTheme: MiniThemes.light);
  runApp(MyHostApp(controller: controller));
}

class MyHostApp extends StatelessWidget {
  final MiniThemeController controller;

  const MyHostApp({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = controller.theme;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: MiniThemeProvider(
        theme: theme,
        child: WidgetsApp(
          color: theme.colors.background,
          builder: (context, _) {
            return Center(
              child: MiniButton(
                label: 'Hello MiniUi',
                onPressed: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
```

这样就可以在任意 Flutter 工程中，以「无 Material、可多主题」的方式复用 MiniUi 提供的底层组件。  
