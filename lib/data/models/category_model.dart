import 'dart:convert';

CaterogyModel caterogyListModelFromJson(String str) => CaterogyModel.fromJson(json.decode(str));

String caterogyListModelToJson(CaterogyModel data) => json.encode(data.toJson());

class CaterogyModel {
  CaterogyModel({
    required this.message,
    required this.data,
  });

  String message;
  List<Category> data;

  factory CaterogyModel.fromJson(Map<String, dynamic> json) => CaterogyModel(
    message: json["message"],
    data: List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String string(){
    return '${data.map((e) => '\n' + e.toString()).toList()}\n';
  }
}

class Category {
  Category({
    required this.id,
    required this.nameRu,
    required this.nameUz,
  });

  int id;
  String nameRu;
  String nameUz;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    nameRu: json["name_ru"],
    nameUz: json["name_uz"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_ru": nameRu,
    "name_uz": nameUz,
  };

  String toString(){
    return 'id: $id | name_ru: $nameRu | name_uz: $nameUz';
  }
}
