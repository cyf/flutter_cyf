import 'package:flutter/material.dart';

import 'package:flutter_cyf/common/mock/bottom_tabs.dart';
import 'package:flutter_cyf/ui/material/pages/news/news_page.dart';
import 'package:flutter_cyf/ui/material/pages/photos/photos_page.dart';
import 'package:flutter_cyf/ui/material/pages/video/video_page.dart';
import 'package:flutter_cyf/ui/material/pages/webview/webview_page.dart';
import 'package:flutter_cyf/ui/material/pages/settings/settings_page.dart';

List<Map<String, Object>> tabsWithWidget = [
  {
    "title": newsTitle,
    "icon": Icons.fiber_new,
    "activeIcon": Icons.fiber_new,
    "widget": (title) => NewsPage(
      headerTitle: title,
    )
  },
  {
    "title": photosTitle,
    "icon": Icons.photo_camera,
    "activeIcon": Icons.photo_camera,
    "widget": (title) => PhotosPage(
      headerTitle: title,
    )
  },
  {
    "title": videoTitle,
    "icon": Icons.videocam,
    "activeIcon": Icons.videocam,
    "widget": (title) => VideoPage(
      headerTitle: title,
    )
  },
  {
    "title": webViewTitle,
    "icon": Icons.web,
    "activeIcon": Icons.web,
    "widget": (title) => WebViewPage(
      headerTitle: title,
    )
  },
  {
    "title": settingsTitle,
    "icon": Icons.settings,
    "activeIcon": Icons.settings,
    "widget": (title) => SettingsPage(
      headerTitle: title,
    )
  }
];