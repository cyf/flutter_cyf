import 'package:flutter/cupertino.dart';

enum VideoCardType {
  standard,
  tappable,
  selectable,
}

class VideoModel {
  const VideoModel({
    @required this.url,
    @required this.cover,
    @required this.title,
    @required this.description,
    @required this.city,
    @required this.location,
    this.type = VideoCardType.standard,
  })  : assert(url != null),
        assert(cover != null),
        assert(title != null),
        assert(description != null),
        assert(city != null),
        assert(location != null);

  final String url;
  final String cover;
  final String title;
  final String description;
  final String city;
  final String location;
  final VideoCardType type;
}
