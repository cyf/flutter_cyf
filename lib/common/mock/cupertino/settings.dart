import 'package:flutter/cupertino.dart';

import 'package:flutter_cyf/common/utils/navigator_util.dart';
import 'package:flutter_cyf/ui/cupertino/pages/settings/author.dart';
import 'package:flutter_cyf/ui/cupertino/pages/settings/about.dart';
import 'package:flutter_cyf/ui/cupertino/pages/settings/feedback.dart';
import 'package:flutter_cyf/ui/cupertino/pages/settings/dark_mode.dart';
import 'package:flutter_cyf/ui/cupertino/pages/settings/l10n.dart';
import 'package:flutter_cyf/ui/cupertino/pages/settings/top_tab.dart';
import 'package:flutter_cyf/ui/cupertino/pages/samples/samples_page.dart';

List<Map<String, Object>> settings = [
  {
    "title": "底部Tab栏",
    "icon": "",
    "navigation": (BuildContext context, String title) => NavigatorUtil.push(
          context,
          TopTab(
            headerTitle: title,
          ),
        )
  },
  {
    "title": "黑暗模式",
    "icon": "",
    "navigation": (BuildContext context, String title) => NavigatorUtil.push(
          context,
          DarkMode(
            headerTitle: title,
          ),
        )
  },
  {
    "title": "语言环境",
    "icon": "",
    "navigation": (BuildContext context, String title) => NavigatorUtil.push(
          context,
          FL10n(
            headerTitle: title,
          ),
        )
  },
  {
    "title": "作者",
    "icon": "",
    "navigation": (BuildContext context, String title) => NavigatorUtil.push(
          context,
          Author(
            headerTitle: title,
          ),
        )
  },
  {
    "title": "关于",
    "icon": "",
    "navigation": (BuildContext context, String title) =>
        showDemoAboutDialog(context)
  },
  {
    "title": "反馈",
    "icon": "",
    "navigation": (BuildContext context, String title) => feedback()
  },
  {
    "title": "示例",
    "icon": "",
    "navigation": (BuildContext context, String title) => NavigatorUtil.push(
          context,
          SamplesPage(
            headerTitle: title,
          ),
        )
  },
];
