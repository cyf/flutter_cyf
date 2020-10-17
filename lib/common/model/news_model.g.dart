// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) {
  return NewsModel(
    title: json['title'] as String,
    url: json['url'] as String,
    date: json['date'] as String,
    comments: json['comments'] as int,
  );
}

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'date': instance.date,
      'comments': instance.comments,
    };
