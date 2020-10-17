import 'package:flutter/material.dart';

import 'package:flutter_cyf/common/mock/material/news.dart';
import 'package:flutter_cyf/ui/material/widgets/samples_item.dart';

class NewsPage extends StatefulWidget {
  final String headerTitle;

  const NewsPage({Key key, this.headerTitle}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> filteredSamples =
        news.where((item) => !(item['hidden'] ?? false)).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.headerTitle ?? "Samples"),
      ),
      body: Container(
        margin: EdgeInsets.all(6),
        child: ListView.separated(
          itemCount: filteredSamples.length,
          itemBuilder: (context, index) => SamplesItem(
            title: filteredSamples[index]["title"],
            description: filteredSamples[index]["description"],
            navigation: (filteredSamples[index]["navigation"] as Function),
          ),
          separatorBuilder: (context, index) => Container(
            height: 10,
          ),
        ),
      ),
    );
  }
}
