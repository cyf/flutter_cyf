import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

class TopTab extends StatefulWidget {
  final String headerTitle;

  const TopTab({Key key, this.headerTitle}) : super(key: key);

  @override
  _TopTabState createState() => _TopTabState();
}

class _TopTabState extends State<TopTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.headerTitle ?? "TopTab"),
          bottom: TabBar(
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
              )
            ],
          ),
        ),
        body: TabBarView(children: [
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
        ]),
      ),
    );
  }
}
