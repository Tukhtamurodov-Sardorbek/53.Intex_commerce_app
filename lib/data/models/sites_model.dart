import 'dart:convert';

SitesModel sitesModelFromJson(String str) => SitesModel.fromJson(json.decode(str));

String sitesModelToJson(SitesModel data) => json.encode(data.toJson());

class SitesModel {
  SitesModel({
    required this.message,
    required this.data,
  });

  String message;
  List<SitesModelData> data;

  factory SitesModel.fromJson(Map<String, dynamic> json) => SitesModel(
    message: json["message"],
    data: List<SitesModelData>.from(json["data"].map((x) => SitesModelData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SitesModelData {
  SitesModelData({
    required this.phoneNumber,
    required this.addressRu,
    required this.addressUz,
    required this.workTimeRu,
    required this.workTimeUz,
    required this.telegramLink,
    required this.instagramLink,
  });

  String phoneNumber;
  String addressRu;
  String addressUz;
  String workTimeRu;
  String workTimeUz;
  String telegramLink;
  String instagramLink;

  factory SitesModelData.fromJson(Map<String, dynamic> json) => SitesModelData(
    phoneNumber: json["phone_number"],
    addressRu: json["address_ru"],
    addressUz: json["address_uz"],
    workTimeRu: json["work_time_ru"],
    workTimeUz: json["work_time_uz"],
    telegramLink: json["telegram_link"],
    instagramLink: json["instagram_link"],
  );

  Map<String, dynamic> toJson() => {
    "phone_number": phoneNumber,
    "address_ru": addressRu,
    "address_uz": addressUz,
    "work_time_ru": workTimeRu,
    "work_time_uz": workTimeUz,
    "telegram_link": telegramLink,
    "instagram_link": instagramLink,
  };
}
