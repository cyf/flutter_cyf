import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_cyf/common/utils/navigator_util.dart';
import 'package:flutter_cyf/common/app_manager.dart';
import 'package:flutter_cyf/common/mock/cupertino/videos.dart';
import 'package:flutter_cyf/common/enum/theme_mode.dart';
import 'package:flutter_cyf/common/model/app_state.dart';
import 'package:flutter_cyf/common/utils/dark_mode_util.dart';
import 'package:flutter_cyf/ui/cupertino/pages/video/video_page.dart';
import 'package:flutter_cyf/ui/cupertino/widgets/search.dart';

class VideoCards extends StatefulWidget {
  @override
  _VideoCardsState createState() => _VideoCardsState();
}

class _VideoCardsState extends State<VideoCards> {
  ShapeBorder _shape;

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    CupertinoThemeData theme = CupertinoTheme.of(context);
    FThemeMode darkMode = StoreProvider.of<AppState>(context).state.darkMode;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        brightness: DarkModeUtil.isDarkMode(context, darkMode)
            ? Brightness.dark
            : Brightness.light,
        backgroundColor: theme.barBackgroundColor,
        middle: Search(
          hideLeft: true,
          hideRight: true,
          hideSpeak: true,
          hint: '搜索',
        ),
      ),
      child: Container(
        color: DarkModeUtil.isDarkMode(context, darkMode)
            ? CupertinoColors.black
            : CupertinoColors.white,
        padding: EdgeInsets.only(
          top: top + 44,
          bottom: AppManager().kBottomNavigationBarHeight,
        ),
        child: Scrollbar(
          child: ListView(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            children: List.generate(videos.length, (int index) {
              VideoModel video = videos[index];
              Widget child;
              switch (video.type) {
                case VideoCardType.standard:
                  child = VideoCardItem(
                    video: video,
                    shape: _shape,
                  );
                  break;
                case VideoCardType.tappable:
                  child = TappableVideoCardItem(
                    video: video,
                    shape: _shape,
                  );
                  break;
                case VideoCardType.selectable:
                  child = SelectableVideoCardItem(
                    video: video,
                    shape: _shape,
                  );
                  break;
              }

              return GestureDetector(
                onTap: () => NavigatorUtil.push(context, VideoPage(headerTitle: video.title,)),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: child,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class VideoCardItem extends StatelessWidget {
  const VideoCardItem({
    Key key,
    @required this.video,
    this.shape,
  })  : assert(video != null),
        super(key: key);

  // This height will allow for all the Card's content to fit comfortably within the card.
  static const double height = 370.0;
  final VideoModel video;
  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) {
    FThemeMode darkMode = StoreProvider.of<AppState>(context).state.darkMode;
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const SectionTitle(title: 'Normal'),
            SizedBox(
              height: height,
              child: Card(
                // This ensures that the Card's children are clipped correctly.
                clipBehavior: Clip.antiAlias,
                shadowColor: DarkModeUtil.isDarkMode(context, darkMode)
                    ? Colors.white
                    : Colors.black,
                shape: shape,
                child: VideoContent(
                  video: video,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TappableVideoCardItem extends StatelessWidget {
  const TappableVideoCardItem({
    Key key,
    @required this.video,
    this.shape,
  })  : assert(video != null),
        super(key: key);

  // This height will allow for all the Card's content to fit comfortably within the card.
  static const double height = 306.0;
  final VideoModel video;
  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const SectionTitle(title: 'Tappable'),
            SizedBox(
              height: height,
              child: Card(
                // This ensures that the Card's children (including the ink splash) are clipped correctly.
                clipBehavior: Clip.antiAlias,
                shape: shape,
                child: InkWell(
                  onTap: () {
                    print('Card was tapped');
                  },
                  // Generally, material cards use onSurface with 12% opacity for the pressed state.
                  splashColor:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                  // Generally, material cards do not have a highlight overlay.
                  highlightColor: Colors.transparent,
                  child: VideoContent(
                    video: video,
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

class SelectableVideoCardItem extends StatefulWidget {
  const SelectableVideoCardItem({
    Key key,
    @required this.video,
    this.shape,
  })  : assert(video != null),
        super(key: key);

  final VideoModel video;
  final ShapeBorder shape;

  @override
  _SelectableVideoCardItemState createState() =>
      _SelectableVideoCardItemState();
}

class _SelectableVideoCardItemState extends State<SelectableVideoCardItem> {
  // This height will allow for all the Card's content to fit comfortably within the card.
  static const double height = 306.0;
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const SectionTitle(title: 'Selectable (long press)'),
            SizedBox(
              height: height,
              child: Card(
                // This ensures that the Card's children (including the ink splash) are clipped correctly.
                clipBehavior: Clip.antiAlias,
                shape: widget.shape,
                child: InkWell(
                  onLongPress: () {
                    print('Selectable card state changed');
                    setState(() {
                      _isSelected = !_isSelected;
                    });
                  },
                  // Generally, material cards use onSurface with 12% opacity for the pressed state.
                  splashColor: colorScheme.onSurface.withOpacity(0.12),
                  // Generally, material cards do not have a highlight overlay.
                  highlightColor: Colors.transparent,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        color: _isSelected
                            // Generally, material cards use primary with 8% opacity for the selected state.
                            // See: https://material.io/design/interaction/states.html#anatomy
                            ? colorScheme.primary.withOpacity(0.08)
                            : Colors.transparent,
                      ),
                      VideoContent(video: widget.video),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.check_circle,
                            color: _isSelected
                                ? colorScheme.primary
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ],
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

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    FThemeMode darkMode = StoreProvider.of<AppState>(context).state.darkMode;
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 12.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: Theme.of(context).textTheme.subhead.copyWith(
                color: DarkModeUtil.isDarkMode(context, darkMode)
                    ? CupertinoColors.white
                    : CupertinoColors.black,
              ),
        ),
      ),
    );
  }
}

class VideoContent extends StatelessWidget {
  const VideoContent({Key key, @required this.video})
      : assert(video != null),
        super(key: key);

  final VideoModel video;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    FThemeMode darkMode = StoreProvider.of<AppState>(context).state.darkMode;
    final TextStyle titleStyle = theme.textTheme.headline.copyWith(
        color: DarkModeUtil.isDarkMode(context, darkMode)
            ? CupertinoColors.white
            : CupertinoColors.black);
    final TextStyle descriptionStyle = theme.textTheme.subhead.copyWith(
        color: DarkModeUtil.isDarkMode(context, darkMode)
            ? CupertinoColors.white
            : CupertinoColors.black);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Photo and title.
        SizedBox(
          height: 184.0,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Ink.image(
                  image: AssetImage(video.cover),
                  fit: BoxFit.cover,
                  child: Container(),
                ),
//                child: Chewie(
//                  controller: chewieController,
//                ),
              ),
//              Positioned(
//                bottom: 16.0,
//                left: 16.0,
//                right: 16.0,
//                child: FittedBox(
//                  fit: BoxFit.scaleDown,
//                  alignment: Alignment.centerLeft,
//                  child: Text(
//                    video.title,
//                    style: titleStyle,
//                  ),
//                ),
//              ),
            ],
          ),
        ),
        Container(
          color: DarkModeUtil.isDarkMode(context, darkMode)
              ? CupertinoColors.black
              : CupertinoColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 8, right: 8),
                child: DefaultTextStyle(
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: descriptionStyle,
                  child: Text(
                    video.title,
                    style: titleStyle,
                  ),
                ),
              ),
              // Description and share/explore buttons.
              Container(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                child: DefaultTextStyle(
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: descriptionStyle,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // three line description
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          video.description,
                          style: descriptionStyle.copyWith(
                              color: DarkModeUtil.isDarkMode(context, darkMode)
                                  ? Colors.white54
                                  : Colors.black54),
                        ),
                      ),
                      Text(video.city),
                      Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Text(video.location),
                      )
                    ],
                  ),
                ),
              ),
              if (video.type == VideoCardType.standard)
                // share, explore buttons
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      child:
                          Text('SHARE', semanticsLabel: 'Share ${video.title}'),
                      textColor: Colors.amber.shade500,
                      onPressed: () {
                        print('pressed');
                      },
                    ),
                    FlatButton(
                      child: Text('EXPLORE',
                          semanticsLabel: 'Explore ${video.title}'),
                      textColor: Colors.amber.shade500,
                      onPressed: () {
                        print('pressed');
                      },
                    ),
                  ],
                ),
            ],
          ),
        )
      ],
    );
  }
}
