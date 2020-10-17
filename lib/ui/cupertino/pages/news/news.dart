import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

import 'package:flutter_cyf/common/apis/news_api.dart';
import 'package:flutter_cyf/common/model/news_model.dart';
import 'package:flutter_cyf/common/enum/theme_mode.dart';
import 'package:flutter_cyf/common/model/app_state.dart';
import 'package:flutter_cyf/common/model/result_model.dart';
import 'package:flutter_cyf/common/utils/dark_mode_util.dart';
import 'package:flutter_cyf/common/utils/navigator_util.dart';
import 'package:flutter_cyf/ui/cupertino/widgets/search.dart';
import 'package:flutter_cyf/ui/cupertino/widgets/sticky_header.dart';

List<String> topTabTitles = [
  '关注',
  '推荐',
  '热点',
  '抗疫',
  '国际',
  '吐槽',
  '科技',
  '国际',
  '音乐',
  '影视',
  '问答',
];

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  double _positionedTop = 0;
  List<NewsModel> _news = [];
  int _currentTopTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadDataFromNetwork();
  }

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    double bottom = MediaQuery.of(context).padding.bottom;
    FThemeMode darkMode = StoreProvider.of<AppState>(context).state.darkMode;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Search(
          hideLeft: true,
          hideRight: true,
          hideSpeak: true,
          hint: '搜索',
        ),
      ),
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: Stack(
        children: <Widget>[
//          Container(
//            color: CupertinoColors.systemBlue,
//            margin: EdgeInsets.only(top: top + 44),
//            child: NewsSwiper(),
//          ),
          Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.only(top: 36.0, bottom: bottom),
            child: NotificationListener(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  _onScroll(scrollNotification.metrics.pixels);
                }
              },
              child: _currentTopTabIndex != 3
                  ? _news.isNotEmpty
                      ? ListView.builder(
                          itemCount: _news?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) =>
                              NewsRowItem(
                            news: _news[index],
                            index: index,
                            lastItem: index == _news?.length - 1,
                          ),
                        )
                      : Container()
                  : Center(
                      child: Container(
                        child: Text(
                          '抗疫必胜',
                          style: TextStyle(
                            color: DarkModeUtil.isDarkMode(context, darkMode)
                                ? CupertinoColors.white
                                : CupertinoColors.black,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          Positioned(
            top: top + 44,
//            top: _positionedTop + top + 44,
            left: 0,
            child: StickyHeader(
              header: Container(
                height: 36,
                width: MediaQuery.of(context).size.width - 30,
                alignment: Alignment.centerLeft,
                child: ListView.builder(
                  itemCount: topTabTitles.length,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentTopTabIndex = index;
                      });
                    },
                    child: Container(
                      height: 36,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 6, right: 6),
                      child: Text(
                        topTabTitles[index],
                        style: TextStyle(
                          fontSize: 14,
                          color: _currentTopTabIndex == index
                              ? CupertinoColors.systemOrange
                              : DarkModeUtil.isDarkMode(context, darkMode)
                                  ? CupertinoColors.white
                                  : CupertinoColors.black,
                        ),
                      ),
                    ),
                  ),
                  scrollDirection: Axis.horizontal,
                ),
//                child: Text(
//                  'Custom Tab Bar',
//                  style: TextStyle(
//                    fontSize: 14,
//                    fontWeight: FontWeight.w500,
//                    color: DarkModeUtil.isDarkMode(context, darkMode)
//                        ? CupertinoColors.white
//                        : CupertinoColors.black,
//                  ),
//                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onScroll(double pixels) {
    double offset = pixels >= 0 ? 0 : -pixels;
    setState(() {
      _positionedTop = offset;
    });
  }

  void _loadDataFromNetwork() async {
    ResultModel<NewsModel> resultModel = await NewsAPi.fetch();

    List<NewsModel> news = resultModel.data;

    setState(() {
      _news = news;
    });
  }
}

class NewsRowItem extends StatelessWidget {
  const NewsRowItem({this.news, this.index, this.lastItem});

  final NewsModel news;
  final int index;
  final bool lastItem;

  @override
  Widget build(BuildContext context) {
    final Widget row = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute<void>(
          title: news.title,
          builder: (BuildContext context) => NewsItemPage(
            title: news.title,
            index: index,
          ),
        ));
      },
      child: Container(
        color: CupertinoDynamicColor.resolve(
            CupertinoColors.systemBackground, context),
        child: SafeArea(
          top: false,
          bottom: false,
          child: Container(
            margin: const EdgeInsets.only(left: 16.0, right: 8.0),
            padding: EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  height: 80.0,
                  width: 100.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      news.url,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
//                    color: CupertinoColors.systemGrey,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 36,
                          child: Text(
                            news.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 16.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              news.date,
                              style: TextStyle(
                                color: CupertinoDynamicColor.resolve(
                                    CupertinoColors.secondaryLabel, context),
                                fontSize: 13.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              '${news.comments}评论',
                              style: TextStyle(
                                color: CupertinoDynamicColor.resolve(
                                    CupertinoColors.secondaryLabel, context),
                                fontSize: 13.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (lastItem) {
      return row;
    }

    return Column(
      children: <Widget>[
        row,
        Container(
          height: 1.0,
          margin: const EdgeInsets.only(left: 16.0, right: 8.0),
          padding: EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
          ),
          color:
              CupertinoDynamicColor.resolve(CupertinoColors.separator, context),
        ),
      ],
    );
  }
}

class NewsItemPage extends StatefulWidget {
  const NewsItemPage({this.title, this.index});

  final String title;
  final int index;

  @override
  State<StatefulWidget> createState() => NewsItemPageState();
}

class NewsItemPageState extends State<NewsItemPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        leading: BackButton(),
      ),
      child: SafeArea(
        top: false,
        bottom: false,
        child: ListView(
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 16.0)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    height: 128.0,
                    width: 128.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24.0),
                      child: Image.asset(
                        'assets/images/bg0.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 18.0)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          widget.title,
                          style: const TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 6.0)),
                        Text(
                          '114评论',
                          style: TextStyle(
                            color: CupertinoDynamicColor.resolve(
                                CupertinoColors.secondaryLabel, context),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CupertinoButton.filled(
                              minSize: 30.0,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              borderRadius: BorderRadius.circular(32.0),
                              child: const Text(
                                'LIKE',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.28,
                                ),
                              ),
                              onPressed: () {},
                            ),
                            CupertinoButton.filled(
                              minSize: 30.0,
                              padding: EdgeInsets.zero,
                              borderRadius: BorderRadius.circular(32.0),
                              child: const Icon(CupertinoIcons.ellipsis),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 28.0, bottom: 8.0),
              child: Text(
                'USERS ALSO LIKED',
                style: TextStyle(
                  color: Color(0xFF646464),
                  letterSpacing: -0.60,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 200.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemExtent: 160.0,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/bg${index}.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
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

class BackButton extends StatelessWidget {
  const BackButton();

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: const Icon(CupertinoIcons.back),
      onPressed: () {
        NavigatorUtil.pop(context);
      },
    );
  }
}

const List<String> images = [
  "assets/images/bg0.jpeg",
  "assets/images/bg1.jpeg",
  "assets/images/bg2.jpeg",
];

class NewsSwiper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        height: 240,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: new Swiper(
          itemBuilder: (BuildContext context, int index) {
            return new Image.asset(
              images[index],
              fit: BoxFit.fill,
            );
          },
          indicatorLayout: PageIndicatorLayout.COLOR,
          autoplay: true,
          itemCount: images.length,
          pagination: new SwiperPagination(),
        ));
  }
}
