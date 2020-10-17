import 'package:flutter/material.dart';

import 'package:flutter_cyf/common/utils/navigator_util.dart';
import 'package:flutter_cyf/ui/material/pages/news/animation.dart';
import 'package:flutter_cyf/ui/material/pages/news/contacts.dart';
import 'package:flutter_cyf/ui/material/pages/news/editable_top_tab.dart';
import 'package:flutter_cyf/ui/material/pages/news/gallery.dart';
import 'package:flutter_cyf/ui/material/pages/news/notification.dart';
import 'package:flutter_cyf/ui/material/pages/news/share.dart';
import 'package:flutter_cyf/ui/material/pages/news/swiper.dart';
import 'package:flutter_cyf/ui/material/pages/news/top_tab.dart';

List<Map<String, Object>> news = [
  {
    "title": "相册示例",
    "description": "相册示例",
    "navigation": (BuildContext context, String title) => NavigatorUtil.push(
      context,
      Gallery(
        headerTitle: title,
      ),
    ),
  },
  {
    "title": "滑块视图示例",
    "description": "滑块视图示例",
    "navigation": (BuildContext context, String title) => NavigatorUtil.push(
      context,
      FSwiper(
        headerTitle: title,
      ),
    )
  },
  {
    "title": "顶部Tab页示例",
    "description": "顶部Tab页示例",
    "navigation": (BuildContext context, String title) => NavigatorUtil.push(
      context,
      TopTab(
        headerTitle: title,
      ),
    )
  },
  {
    "title": "可编辑顶部Tab页示例",
    "description": "可编辑顶部Tab页示例",
    "navigation": (BuildContext context, String title) => NavigatorUtil.push(
      context,
      EditableTopTab(
        headerTitle: title,
      ),
    )
  },
  {
    "title": "通讯录示例",
    "description": "通讯录示例",
    "navigation": (BuildContext context, String title) => NavigatorUtil.push(
          context,
          Contacts(
            headerTitle: title,
          ),
        )
  },
  {
    "title": "通知推送示例",
    "description": "通知推送示例",
    "hidden": true,
    "navigation": (BuildContext context, String title) => NavigatorUtil.push(
      context,
      NotificationPage(
        headerTitle: title,
      ),
    )
  },
  {
    "title": "分享示例",
    "description": "分享示例",
    "hidden": true,
    "navigation": (BuildContext context, String title) => NavigatorUtil.push(
      context,
      Share(
        headerTitle: title,
      ),
    )
  },
  {
    "title": "动画示例",
    "description": "动画示例",
    "hidden": true,
    "navigation": (BuildContext context, String title) => NavigatorUtil.push(
      context,
      AnimationPage(
        headerTitle: title,
      ),
    )
  },
];
