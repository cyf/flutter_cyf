import 'package:flutter/cupertino.dart';

import 'package:flutter_cyf/common/mock/bottom_tabs.dart';
import 'package:flutter_cyf/ui/cupertino/pages/photos/photos_page.dart';
import 'package:flutter_cyf/ui/cupertino/pages/webview/webview_page.dart';
import 'package:flutter_cyf/ui/cupertino/pages/settings/settings_page.dart';
import 'package:flutter_cyf/ui/cupertino/pages/news/news.dart';
import 'package:flutter_cyf/ui/cupertino/pages/video/video_cards.dart';

List<Map<String, Object>> tabsWithWidget = [
  {
    "title": newsTitle,
    "icon": CupertinoIcons.news,
    "activeIcon": CupertinoIcons.news_solid,
    "widget": (title) => News()
  },
  {
    "title": photosTitle,
    "icon": CupertinoIcons.photo_camera,
    "activeIcon": CupertinoIcons.photo_camera_solid,
    "widget": (title) => PhotosPage(
      headerTitle: title,
    )
  },
  {
    "title": videoTitle,
    "icon": CupertinoIcons.video_camera,
    "activeIcon": CupertinoIcons.video_camera_solid,
    "widget": (title) => VideoCards()
  },
  {
    "title": webViewTitle,
    "icon": CupertinoIcons.bookmark,
    "activeIcon": CupertinoIcons.bookmark_solid,
    "widget": (title) => WebViewPage(
      headerTitle: title,
    )
  },
  {
    "title": settingsTitle,
    "icon": CupertinoIcons.settings,
    "activeIcon": CupertinoIcons.settings_solid,
    "widget": (title) => SettingsPage(
      headerTitle: title,
    )
  }
];