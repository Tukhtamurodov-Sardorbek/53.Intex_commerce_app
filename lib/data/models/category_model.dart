import 'dart:convert';

CaterogyModel caterogyListModelFromJson(String str) => CaterogyModel.fromJson(json.decode(str));

String caterogyListModelToJson(CaterogyModel data) => json.encode(data.toJson());

class CaterogyModel {
  CaterogyModel({
    required this.message,
    required this.data,
  });

  String message;
  List<CategoryData> data;

  factory CaterogyModel.fromJson(Map<String, dynamic> json) => CaterogyModel(
    message: json["message"],
    data: List<CategoryData>.from(json["data"].map((x) => CategoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String string(){
    return '${data.map((e) => '\n' + e.toString()).toList()}\n';
  }
}

class CategoryData {
  CategoryData({
    required this.id,
    required this.nameRu,
    required this.nameUz,
  });

  int id;
  String nameRu;
  String nameUz;

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
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
