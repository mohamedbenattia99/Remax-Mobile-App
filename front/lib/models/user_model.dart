import 'package:authentification/models/demande.dart';

class UserModel {
  String id;
  String first_name;
  String last_name;
  String email;
  String email_verified_at;
  String phone;
  String deleted_at;
  String created_at;
  String updated_at;
  double longitude;
  double latitude;
  String role;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    first_name = json["first_name"];
    last_name = json["last_name"];
    phone = json["phone"];
    if (json["address"] != null) {
      longitude = json["address"]["longitude"];
      latitude = json["address"]["latitude"];
    }
    email = json["email"];
    role = json["role"] != null ? json["role"]["name"] : "";
  }
}

class Client extends UserModel {
  List orders;
  Client.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json["orders"] != null)
      json["orders"].forEach((f) {
        orders.add(Demande.fromJson(f));
      });
  }
}

class Affiliate extends UserModel {
  String affiliate_name;
  double distance;
  dynamic performance;
  dynamic completed;
  Affiliate.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    id = json["id"];
    affiliate_name = json["affiliate_details"] != null
        ? json["affiliate_details"]["affiliate_name"]
        : json["affiliate_name"] ?? "";
    performance = json["performance"];
    completed = json["completed"];
  }
  setAffiliateName(value) => affiliate_name = value;
  setPerformance(value) => performance = value;
  setDistance(value) => distance = value;
}
