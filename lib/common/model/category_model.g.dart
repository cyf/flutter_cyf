// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) {
  return CategoryModel(
    categoryNameEn: json['category_name_en'] as String,
    categoryName: json['category_name'] as String,
    categoryId: json['category_id'] as int,
    categoryList: (json['category_list'] as List)
        ?.map((e) => e == null
            ? null
            : CategoryProducts.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    isDefault: json['is_default'] as bool,
  );
}

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'category_name_en': instance.categoryNameEn,
      'category_name': instance.categoryName,
      'category_id': instance.categoryId,
      'category_list': instance.categoryList,
      'is_default': instance.isDefault,
    };

CategoryProducts _$CategoryProductsFromJson(Map<String, dynamic> json) {
  return CategoryProducts(
    viewType: json['view_type'] as String,
    isShow: json['is_show'] as String,
    stat: json['stat'] as String,
    body: json['body'] == null
        ? null
        : Body.fromJson(json['body'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CategoryProductsToJson(CategoryProducts instance) =>
    <String, dynamic>{
      'view_type': instance.viewType,
      'is_show': instance.isShow,
      'stat': instance.stat,
      'body': instance.body,
    };

Body _$BodyFromJson(Map<String, dynamic> json) {
  return Body(
    w: json['w'] as int,
    h: json['h'] as int,
    categoryName: json['category_name'] as String,
    items: (json['items'] as List)
        ?.map(
            (e) => e == null ? null : Items.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    action: json['action'] == null
        ? null
        : Action.fromJson(json['action'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'w': instance.w,
      'h': instance.h,
      'category_name': instance.categoryName,
      'items': instance.items,
      'action': instance.action,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) {
  return Items(
    imgUrl: json['img_url'] as String,
    imgUrlWebp: json['img_url_webp'] as String,
    pathType: json['path_type'] as String,
    imgUrlColor: json['img_url_color'] as String,
    action: json['action'] == null
        ? null
        : Action.fromJson(json['action'] as Map<String, dynamic>),
    w: json['w'] as int,
    h: json['h'] as int,
    categoryName: json['category_name'] as String,
    productName: json['product_name'] as String,
  );
}

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'img_url': instance.imgUrl,
      'img_url_webp': instance.imgUrlWebp,
      'path_type': instance.pathType,
      'img_url_color': instance.imgUrlColor,
      'action': instance.action,
      'w': instance.w,
      'h': instance.h,
      'category_name': instance.categoryName,
      'product_name': instance.productName,
    };

Action _$ActionFromJson(Map<String, dynamic> json) {
  return Action(
    type: json['type'] as String,
    path: json['path'] as String,
    logCode: json['log_code'] as String,
  );
}

Map<String, dynamic> _$ActionToJson(Action instance) => <String, dynamic>{
      'type': instance.type,
      'path': instance.path,
      'log_code': instance.logCode,
    };
