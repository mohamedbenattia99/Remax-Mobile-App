import 'dart:io';

import 'package:authentification/models/user_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //static const endpoint = "http://10.0.2.2:8000/api";
  static const endpoint = "http://151.80.123.213:8000/api";
  static String _token = "";
  Future<dynamic> changePassword(Map<String, dynamic> info) async {
    try {
      print(info);
      http.Response result = await http
          .post("$endpoint/auth/change-password", body: info, headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $_token"
      });
      print(result.statusCode);
      print(result.body);
      if (result.statusCode == 422) return jsonDecode(result.body)["message"];
      print("from change password ");
      print(result.body);
      return Affiliate.fromJson(json.decode(result.body));
    } catch (e) {
      print("from change password");
      print(e);
      return null;
    }
  }

  Future<dynamic> login(String email, String password) async {
    try {
      http.Response result = await http.post("$endpoint/auth/login",
          body: {"email": email, "password": password});
      var js = parseJwt(result.body);
      if (result.statusCode > 400) return null;
      _token = jsonDecode(result.body)["access_token"];
      dynamic user = await getUser(js["sub"]);
      print("login --------------------------------------");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("email", email);
      prefs.setString("password", password);
      print(user);
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> logout() async {
    try {
      // http.Response result = await http.get("$endpoint/auth/logout");
      // print("from logout");
      // print(result.body);
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.remove("email");
      await pref.remove("password");
      return true;
    } catch (e) {
      print("from logout catch");
      print(e);
    }
  }

  Future<dynamic> clientSignup(Map<String, dynamic> info) async {
    try {
      double latitude = await getLatitudeFromAdress(
          "tunisie,${info["governorate"]},${info["municipality"]}");
      double longitude = await getLongitudeFromAdress(
          "tunisie,${info["governorate"]},${info["municipality"]}");
      print("from client signup");
      info["longitude"] = longitude.toString();
      info["latitude"] = latitude.toString();
      print(info);
      http.Response result =
          await http.post("$endpoint/auth/signup/client", body: info);
      print("clien signup -------------------");
      print(result.body);
      print(result.statusCode);
      if (result.statusCode >= 400) return null;
      return "auth";
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<double> getLongitudeFromAdress(String adresse) async {
    List<Placemark> placemark =
        await Geolocator().placemarkFromAddress(adresse);
    Placemark p = placemark[0];
    double longitude = p.position.longitude;

    return longitude;
  }

  Future<double> getLatitudeFromAdress(String adresse) async {
    List<Placemark> placemark =
        await Geolocator().placemarkFromAddress(adresse);
    Placemark p = placemark[0];
    double latitude = p.position.latitude;

    return latitude;
  }

  Future<dynamic> affiliateSignup(Map<String, dynamic> info) async {
    try {
      double latitude = await getLatitudeFromAdress(
          "tunisie,${info["governorate"]},${info["municipality"]}");
      double longitude = await getLongitudeFromAdress(
          "tunisie,${info["governorate"]},${info["municipality"]}");
      print("from affiliate signup auth service");
      print(json.encode(info));
      http.Response result =
          await http.post("$endpoint/auth/signup/affiliate", body: {
        "email": info["email"].trim(),
        "password": info["password"],
        "zip_code": info["zip_code"],
        "governorate": info["governorate"],
        "municipality": info["municipality"],
        "address": info["address"],
        "performance": "0",
        "first_name": info["first_name"],
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
        "last_name": info["last_name"],
        "phone": info["phone"],
        "affiliate_name": info["affiliate_name"],
        "gender": "Male"
      });
      print("affiliate signup -------------------");
      print(result.body);
      if (result.statusCode >= 400) return null;
      return "auth";
    } catch (e) {
      print(e);
      return null;
    }
  }

//auto login
  Future<dynamic> autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email");
    String password = prefs.getString("password");
    if (email == null || password == null) return null;
    return await login(email, password);
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  Future<dynamic> getUser(id) async {
    try {
      print(id);
      http.Response result = await http.get("$endpoint/user/$id");
      print("from get User auth ser---------------------------");
      print(result.body);
      return UserModel.fromJson(json.decode(result.body));
    } catch (e) {
      print(e);
      return null;
    }
  }
}
