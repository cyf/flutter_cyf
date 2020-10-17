import 'package:flutter/material.dart';

import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_cyf/common/utils/navigator_util.dart';
import 'package:flutter_cyf/ui/cupertino/widgets/app_bar.dart';
import 'package:flutter_cyf/ui/cupertino/pages/samples/editable_top_tab_dialog.dart';

class EditableTopTab extends StatefulWidget {
  final String headerTitle;

  const EditableTopTab({Key key, this.headerTitle}) : super(key: key);

  @override
  _EditableTopTabState createState() => _EditableTopTabState();
}

class _EditableTopTabState extends State<EditableTopTab>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          FAppBar(
            title: widget.headerTitle,
            bottom: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 40),
                  child: TabBar(
                    controller: _tabController,
                    labelStyle: TextStyle(fontWeight: FontWeight.w700),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Colors.orangeAccent,
                    unselectedLabelColor: Colors.white,
                    isScrollable: true,
                    indicator: MD2Indicator(
                      indicatorHeight: 3,
                      indicatorColor: Colors.orangeAccent,
                      indicatorSize: MD2IndicatorSize.full,
                    ),
                    tabs: <Widget>[
                      Tab(
                        text: "Home",
                      ),
                      Tab(
                        text: "Personal",
                      ),
                      Tab(
                        text: "personalization",
                      ),
                      Tab(
                        text: "Security",
                      ),
                      Tab(
                        text: "Beauty",
                      )
                    ],
                  ),
                ),
                Positioned(
                  child: GestureDetector(
                    onTap: () => NavigatorUtil.push(context, EditableTopTabDialog()),
                    child: Container(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.list,
                        size: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  right: 6,
                  top: 10,
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://assets.chenyifaer.com/cyf-apps/chenyifaer/assets/bg.jpeg',
                    fit: BoxFit.fitWidth,
                    placeholder: (context, url) => Center(
                      child: Container(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Container(
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://assets.chenyifaer.com/cyf-apps/chenyifaer/assets/bg0.jpeg',
                    fit: BoxFit.fitWidth,
                    placeholder: (context, url) => Center(
                      child: Container(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Container(
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://assets.chenyifaer.com/cyf-apps/chenyifaer/assets/bg1.jpeg',
                    fit: BoxFit.fitWidth,
                    placeholder: (context, url) => Center(
                      child: Container(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Container(
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://assets.chenyifaer.com/cyf-apps/chenyifaer/assets/bg2.jpeg',
                    fit: BoxFit.fitWidth,
                    placeholder: (context, url) => Center(
                      child: Container(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Container(
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://assets.chenyifaer.com/cyf-apps/chenyifaer/assets/bg.jpeg',
                    fit: BoxFit.fitWidth,
                    placeholder: (context, url) => Center(
                      child: Container(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
