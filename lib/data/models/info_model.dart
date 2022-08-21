import 'dart:convert';

InfoModel infoModelFromJson(String str) => InfoModel.fromJson(json.decode(str));

String infoModelToJson(InfoModel data) => json.encode(data.toJson());

class InfoModel {
  String message;
  List<Info> data;

  InfoModel({
    required this.message,
    required this.data,
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) => InfoModel(
    message: json["message"],
    data: List<Info>.from(json["data"].map((x) => Info.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Info {
  String phoneNumber;
  String addressRu;
  String addressUz;
  String workTimeRu;
  String workTimeUz;
  String telegramLink;
  String instagramLink;

  Info({
    required this.phoneNumber,
    required this.addressRu,
    required this.addressUz,
    required this.workTimeRu,
    required this.workTimeUz,
    required this.telegramLink,
    required this.instagramLink,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
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

  String toString(){
    return '\nphone_number: $phoneNumber \naddress_ru: $addressRu \naddress_uz: $addressUz \nwork_time_ru: $workTimeRu \nwork_time_uz: $workTimeUz \ntelegram_link: $telegramLink \ninstagram_link: $instagramLink';
  }
}