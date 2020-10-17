import 'package:flutter/cupertino.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_cyf/common/app_manager.dart';
import 'package:flutter_cyf/common/model/app_state.dart';
import 'package:flutter_cyf/common/utils/dark_mode_util.dart';
import 'package:flutter_cyf/common/enum/theme_mode.dart';
import 'package:flutter_cyf/common/apis/categories_api.dart';
import 'package:flutter_cyf/common/model/category_model.dart';
import 'package:flutter_cyf/ui/cupertino/widgets/search.dart';

class PhotosPage extends StatefulWidget {
  final String headerTitle;

  const PhotosPage({Key key, this.headerTitle}) : super(key: key);

  @override
  _PhotosPageState createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  ScrollController _scrollController;
  int _currentIndex = 0;
  List<CategoryModel> categories = [];

  @override
  void initState() {
    super.initState();
    _loadFromNetwork();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double top = MediaQuery.of(context).padding.top;
    double _kBottomNavigationBarHeight =
        AppManager().kBottomNavigationBarHeight;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Search(
          hideLeft: true,
          hideRight: true,
          hideSpeak: true,
          hint: '搜索',
        ),
      ),
      child: categories.isNotEmpty ? Container(
//        height: height - top - kToolbarHeight - _kBottomNavigationBarHeight,
        child: Row(
          children: <Widget>[
            StoreConnector<AppState, FThemeMode>(
              converter: (store) => store.state.darkMode,
              builder: (context, darkMode) => Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: DarkModeUtil.isDarkMode(context, darkMode)
                          ? CupertinoColors.white.withOpacity(0.3)
                          : CupertinoColors.black.withOpacity(0.3),
                    ),
                  ),
                ),
                width: 88,
//                height:
//                    height - top - kToolbarHeight - _kBottomNavigationBarHeight,
                child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        child: _ProductCategoryItem(
                          label: categories[index].categoryName,
                          highlight: index == _currentIndex,
                        ),
                      ),
                  itemCount: categories.length,
                ),
              ),
            ),
            Expanded(
              child: Container(
//                height:
//                    height - top - kToolbarHeight - _kBottomNavigationBarHeight,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    CategoryProducts categoryProduct =
                    categories[_currentIndex]?.categoryList[index];
                    String viewType = categoryProduct?.viewType;
                    switch (viewType) {
                      case 'cells_auto_fill':
                        String url = categoryProduct?.body?.items[0]?.imgUrl??'';
                        return _ProductCategoryFill(url: url,);
                      case 'category_title':
                        String title = categoryProduct?.body?.categoryName;
                        return _ProductCategoryTitle(title: title);
                      case 'category_group':
                        List<Items> items = categoryProduct?.body?.items;
                        return _ProductCategoryGroup(
                          items: items,
                        );
                    }
                  },
                  itemCount:
                  categories[_currentIndex]?.categoryList?.length ?? 0,
                ),
              ),
            ),
          ],
        ),
      ) : Container(),
    );
  }

  void _loadFromNetwork() async {
    List<CategoryModel> data = await CategoriesAPi.fetch();
    setState(() {
      categories = data;
    });
  }
}

class _ProductCategoryItem extends StatelessWidget {
  final String label;
  final bool highlight;

  const _ProductCategoryItem({Key key, this.label, this.highlight = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      child: Container(
        margin: EdgeInsets.only(top: 19, bottom: 19),
        height: 18,
        decoration: highlight
            ? BoxDecoration(
                border: Border(
                  left:
                      BorderSide(color: CupertinoColors.systemOrange, width: 4),
                ),
              )
            : BoxDecoration(),
        padding:
            highlight ? EdgeInsets.only(right: 4) : EdgeInsets.only(left: 0),
        child: StoreConnector<AppState, FThemeMode>(
          converter: (store) => store.state.darkMode,
          builder: (context, darkMode) => Center(
            child: Text(
              label,
              style: TextStyle(
                color: highlight
                    ? CupertinoColors.systemOrange
                    : DarkModeUtil.isDarkMode(context, darkMode)
                        ? CupertinoColors.white
                        : CupertinoColors.black,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductCategoryFill extends StatelessWidget {
  final String url;

  const _ProductCategoryFill({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = TextStyle(color: CupertinoColors.systemGrey);
    return Container(
      width: MediaQuery.of(context).size.width - 88,
      height: 160,
      padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: CachedNetworkImage(
        imageUrl: 'https:${url}',
        placeholder: (context, url) => Center(
          child: Container(
            height: 30,
            width: 30,
            child: CupertinoActivityIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => Icon(CupertinoIcons.info),
      ),
    );
  }
}

class _ProductCategoryTitle extends StatelessWidget {
  final String title;

  const _ProductCategoryTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = TextStyle(color: CupertinoColors.systemGrey);
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '——',
            style: _textStyle,
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              title,
            ),
          ),
          Text(
            '——',
            style: _textStyle,
          ),
        ],
      ),
    );
  }
}

class _ProductCategoryGroup extends StatelessWidget {
  final List<Items> items;

  const _ProductCategoryGroup({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageSize = (MediaQuery.of(context).size.width - 88) * 0.25;
    List<Widget> widgets = List.generate(
      items.length,
      (int index) => _widget(items[index], imageSize),
    );

    return Container(
      width: MediaQuery.of(context).size.width - 88,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: widgets,
            ),
          )
        ],
      ),
    );
  }

  Widget _widget(Items items, double imageSize) {
    return Container(
      margin: EdgeInsets.only(top: 12, left: 8, right: 8),
      child: Column(
        children: <Widget>[
          Container(
            width: imageSize,
            height: imageSize,
            child: CachedNetworkImage(
              imageUrl: 'https:${items.imgUrl}',
              placeholder: (context, url) => Center(
                child: Container(
                  height: 30,
                  width: 30,
                  child: CupertinoActivityIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Icon(CupertinoIcons.info),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 12),
            height: 50,
            width: imageSize,
            child: Text(
              items.productName,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
