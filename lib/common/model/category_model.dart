import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  @JsonKey(name: 'category_name_en')
  String categoryNameEn;
  @JsonKey(name: 'category_name')
  String categoryName;
  @JsonKey(name: 'category_id')
  int categoryId;
  @JsonKey(name: 'category_list', nullable: true)
  List<CategoryProducts> categoryList;
  @JsonKey(name: 'is_default')
  bool isDefault;

  CategoryModel(
      {this.categoryNameEn,
        this.categoryName,
        this.categoryId,
        this.categoryList,
        this.isDefault});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable()
class CategoryProducts {
  @JsonKey(name: 'view_type')
  String viewType;
  @JsonKey(name: 'is_show')
  String isShow;
  @JsonKey(name: 'stat')
  String stat;
  @JsonKey(name: 'body', nullable: true)
  Body body;

  CategoryProducts({this.viewType, this.isShow, this.stat, this.body});

  factory CategoryProducts.fromJson(Map<String, dynamic> json) => _$CategoryProductsFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryProductsToJson(this);
}

@JsonSerializable()
class Body {
  int w;
  int h;
  @JsonKey(name: 'category_name')
  String categoryName;
  @JsonKey(nullable: true)
  List<Items> items;
  Action action;

  Body({this.w, this.h, this.categoryName, this.items, this.action});

  factory Body.fromJson(Map<String, dynamic> json) => _$BodyFromJson(json);
  Map<String, dynamic> toJson() => _$BodyToJson(this);
}

@JsonSerializable()
class Items {
  @JsonKey(name: 'img_url')
  String imgUrl;
  @JsonKey(name: 'img_url_webp')
  String imgUrlWebp;
  @JsonKey(name: 'path_type')
  String pathType;
  @JsonKey(name: 'img_url_color')
  String imgUrlColor;
  @JsonKey(nullable: true)
  Action action;
  int w;
  int h;
  @JsonKey(name: 'category_name')
  String categoryName;
  @JsonKey(name: 'product_name')
  String productName;

  Items(
      {this.imgUrl,
        this.imgUrlWebp,
        this.pathType,
        this.imgUrlColor,
        this.action,
        this.w,
        this.h,
        this.categoryName,
        this.productName});

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);
  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class Action {
  @JsonKey(name: 'type', nullable: true)
  String type;
  @JsonKey(name: 'path', nullable: true)
  String path;
  @JsonKey(name: 'log_code')
  String logCode;

  Action({this.type, this.path, this.logCode});

  factory Action.fromJson(Map<String, dynamic> json) => _$ActionFromJson(json);
  Map<String, dynamic> toJson() => _$ActionToJson(this);
}
