import 'dart:convert';

CategoryByIdModel categoryByIdModelFromJson(String str) => CategoryByIdModel.fromJson(json.decode(str));

String categoryByIdModelToJson(CategoryByIdModel data) => json.encode(data.toJson());

class CategoryByIdModel {
  CategoryByIdModel({
    required this.message,
    required this.data,
  });

  String message;
  List<ProductByIdModel> data;

  factory CategoryByIdModel.fromJson(Map<String, dynamic> json) => CategoryByIdModel(
    message: json["message"],
    data: List<ProductByIdModel>.from(json["data"].map((x) => ProductByIdModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ProductByIdModel {
  ProductByIdModel({
    required this.id,
    required this.categoryNameUz,
    required this.categoryNameRu,
    required this.image,
    required this.price,
    required this.salePrice,
    required this.quantity,
    required this.frameRu,
    required this.frameUz,
    required this.size,
    required this.depth,
    required this.equipmentRu,
    required this.equipmentUz,
    required this.statusRu,
    required this.statusUz,
  });

  int id;
  String categoryNameUz;
  String categoryNameRu;
  String image;
  String price;
  String salePrice;
  String quantity;
  String frameRu;
  String frameUz;
  String size;
  String depth;
  String equipmentRu;
  String equipmentUz;
  String statusRu;
  String statusUz;

  factory ProductByIdModel.fromJson(Map<String, dynamic> json) => ProductByIdModel(
    id: json["id"],
    categoryNameUz: json["category_name_uz"],
    categoryNameRu: json["category_name_ru"],
    image: json["image"],
    price: json["price"],
    salePrice: json["sale_price"],
    quantity: json["quantity"],
    frameRu: json["frame_ru"],
    frameUz: json["frame_uz"],
    size: json["size"],
    depth: json["depth"],
    equipmentRu: json["equipment_ru"],
    equipmentUz: json["equipment_uz"],
    statusRu: json["status_ru"],
    statusUz: json["status_uz"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name_uz": categoryNameUz,
    "category_name_ru": categoryNameRu,
    "image": image,
    "price": price,
    "sale_price": salePrice,
    "quantity": quantity,
    "frame_ru": frameRu,
    "frame_uz": frameUz,
    "size": size,
    "depth": depth,
    "equipment_ru": equipmentRu,
    "equipment_uz": equipmentUz,
    "status_ru": statusRu,
    "status_uz": statusUz,
  };
}
