import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.message,
    required this.data,
  });

  String message;
  List<Product> data;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    message: json["message"],
    data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Product {
  Product({
   required this.id,
   required this.categoryId,
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
   required this.statusId,
   required this.statusRu,
   required this.statusUz,
  });
/*
net prodajidagi button ozgarishi kerak
 */
  int id;
  int categoryId;
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
  int statusId;
  String statusRu;
  String statusUz;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    categoryId: json["category_id"],
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
    statusId: json["status_id"],
    statusRu: json["status_ru"],
    statusUz: json["status_uz"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
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
    "status_id": statusId,
    "status_ru": statusRu,
    "status_uz": statusUz,
  };
}
