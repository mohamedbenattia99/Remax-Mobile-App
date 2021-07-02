import 'dart:io';

import 'package:authentification/models/demande.dart';
import 'package:authentification/models/gov.dart';
import 'package:authentification/models/user_model.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
import 'package:geolocator/geolocator.dart';

class ApiService {
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

//static const endpoint = "http://10.0.2.2:8000/api";
  static const endpoint = "http://151.80.123.213:8000/api";
//get User
  Future<dynamic> getUser(String id) async {
    try {
      http.Response result = await http.get("$endpoint/user/$id");
      if (result.statusCode >= 400) return null;
      print("from get User  ");
      print(result.body);
      return UserModel.fromJson(json.decode(result.body));
    } catch (e) {
      print("from  get User catch");
      print(e);
      return null;
    }
  }

//update profile
  Future<dynamic> updateUser(String id, info, {String user}) async {
    try {
      http.Response result = await http.put("$endpoint/user/$id", body: info);
      if (result.statusCode >= 400) return null;
      print("from update  ");
      print(result.body);
      if (user == "a") return Affiliate.fromJson(json.decode(result.body));
      return UserModel.fromJson(json.decode(result.body));
    } catch (e) {
      print("from  update  catch");
      print(e);
      return null;
    }
  }

//delete affiliate
  Future<dynamic> deleteAffiliate(String id) async {
    try {
      http.Response result = await http.delete("$endpoint/affiliate/$id");
      print(result.statusCode);
      print(result.body);
      print("from delte affiltae");
      return true;
    } catch (e) {
      print("from  delte  aff catch");
      print(e);
      return null;
    }
  }

//update affiliate
  Future<dynamic> updateAffiliate(String id, info, {String user}) async {
    try {
      print(id);
      print(info);
      http.Response result = await http.put(
        "$endpoint/affiliate/$id",
        body: info,
      );
      print(result.statusCode);
      print(result.body);
      if (result.statusCode >= 400) return null;
      print("from update affiltae ");
      print(result.body);
      return Affiliate.fromJson(json.decode(result.body));
    } catch (e) {
      print("from  update  aff catch");
      print(e);
      return null;
    }
  }

//affect client
  Future<dynamic> affectClient(String order_id, String name) async {
    try {
      http.Response result;
      // if(name=="")
      //  result =  await http.put("$endpoint/order/$order_id",body:{
      //     "affiliate_id":null,
      //   });
      result =
          await http.get("$endpoint/assing_order_to_affiliate/$order_id/$name");
      if (result.statusCode > 200) return null;
      print("from affect client");
      print(result.body);
      return result;
    } catch (e) {
      print("from affect client catch");
      print(e);
      return null;
    }
  }

  Future<dynamic> affectClientId(String cid, String id) async {
    try {
      http.Response result = await http.put("$endpoint/order/$id", body: {
        "client_id": cid,
      });

      if (result.statusCode >= 400) return null;
      print("from affect client id");
      print(result.body);
      return result;
    } catch (e) {
      print("from affect client id catch");
      print(e);
      return null;
    }
  }

//get affiliate by id
  Future<dynamic> getAffiliate(id) async {
    try {
      http.Response result = await http.get("$endpoint/affiliate/$id");
      print("from get affiliate");
      print(result.body);
      if (result.statusCode >= 400) return null;
      return Affiliate.fromJson(json.decode(result.body));
    } catch (e) {
      print("from error get affiliate");
      print(e);
      return null;
    }
  }

//get client orders by id
  Future<dynamic> getClientOrders(id) async {
    try {
      http.Response result = await http.get("$endpoint/order/client/$id");
      print(result.body);
      if (result.statusCode > 200) return null;
      var js = jsonDecode(result.body.toString());
      List<Demande> demandes = [];
      js.forEach((demande) {
        demandes.add(Demande.fromJson(demande));
      });
      print("from get order client");
      return demandes;
    } catch (e) {
      print("from get client orders catch");
      print(e);
      return null;
    }
  }

//get affiliate orders by id
  Future<dynamic> getAffiliateOrders(id) async {
    try {
      print(id);
      http.Response result = await http.get("$endpoint/order/affiliate/$id");
      print("from get order Affiliate");
      print(result.body);
      print(result.statusCode);
      if (result.statusCode >= 400) return null;
      var js = jsonDecode(result.body.toString());

      print(js);
      List<Demande> demandes = [];
      js.forEach((demande) {
        demandes.add(Demande.fromJson(demande));
      });
      print(demandes);
      return demandes;
    } catch (e) {
      print("from get affiliate orders catch");
      print(e);
      return null;
    }
  }

//delete order
  Future<dynamic> deleteOrder(String id) async {
    try {
      print(id);
      http.Response result = await http.delete("$endpoint/order/$id");
      print("from delete order ");
      print(result.body);
      if (result.statusCode >= 400) return null;
      var js = json.decode(result.body);
      return true;
    } catch (e) {
      print("from delete  order catch");
      print(e);
      return null;
    }
  }

//get all orders
  Future<dynamic> getOrders() async {
    try {
      http.Response result = await http.get(
        "$endpoint/order",
      );
      print(result.body);
      if (result.statusCode > 200) return null;
      var js = jsonDecode(result.body.toString());
      print("hi");
      List<Demande> demandes = [];
      js.forEach((demande) async {
        demandes.add(Demande.fromJson(demande));
      });
      print("from get order ");
      return demandes;
    } catch (e) {
      print("from get  orders catch");
      print(e);
      return null;
    }
  }

  Future<dynamic> getAddress() async {
    try {
      http.Response result = await http.get("$endpoint/address");
      print(result.body);
      if (result.statusCode > 200) return null;
      var js = json.decode(result.body);
      return js[0]["id"];
    } catch (e) {
      print("from get  address catch");
      print(e);
      return null;
    }
  }

//get alla fiiliates
  Future<dynamic> getAffiliates() async {
    try {
      http.Response result = await http.get("$endpoint/affiliate");
      print(result.body);
      if (result.statusCode > 200) return null;
      var js = json.decode(result.body);
      List<Affiliate> affiliates = [];
      js.forEach((demande) {
        affiliates.add(Affiliate.fromJson(demande));
      });
      print("from affiliate order ");

      return affiliates;
    } catch (e) {
      print("from get  affiliates catch");
      print(e);
      return null;
    }
  }

// add a order

  Future<dynamic> addOrder(Map<String, dynamic> info, cid, pid, aid) async {
    try {
      double latitude = await getLatitudeFromAdress(
          "tunisie,${info["governorate"]},${info["municipality"]}");
      double longitude = await getLongitudeFromAdress(
          "tunisie,${info["governorate"]},${info["municipality"]}");
      var id = await getAddress();
      info["client_id"] = cid ?? "";
      info["city"] = "kjhkjh";
      info["parentCompany_id"] = pid ?? "";
      info["affiliate_id"] = aid ?? "";
      info["latitude"] = latitude.toString();
      info["longitude"] = longitude.toString();
      info["agent"] = "not assigned";

      http.Response result = await http.post("$endpoint/order", body: info);
      print("from add order-------------------------");
      print(result.body);
      if (result.statusCode >= 400) return null;

      return true;
    } catch (e) {
      print("from add order catch");
      print(e);
      return null;
    }
  }

  Future<dynamic> getOrderByCode(String code) async {
    try {
      http.Response result = await http.get("$endpoint/order/code/$code");
      print("from get order by code");
      print(result.body);
      if (result.statusCode >= 400) return null;
      return Demande.fromJson(json.decode(result.body)[0]);
    } catch (e) {
      print("from catch of get order by code");
      print(e);
      return null;
    }
  }

  Future<dynamic> affectAgent(String id, String agent) async {
    try {
      http.Response result =
          await http.put("$endpoint/order/$id", body: {"agent": agent});
      print("from affect client");
      print(result.body);
      if (result.statusCode >= 400) return null;
      return Demande.fromJson(json.decode(result.body));
    } catch (e) {
      print("from catch of affect client");
      print(e);
      return null;
    }
  }

  Future<dynamic> changePhase(String id, int newPhase) async {
    try {
      int completed = newPhase == 4 ? 1 : 0;
      if (newPhase >= 0 && newPhase <= 4) {
        http.Response result = await http.put("$endpoint/order/$id", body: {
          "phase": newPhase.toString(),
          "completed": completed.toString()
        });
        print("from change Phase");
        print(result.body);
        if (result.statusCode >= 400) return null;
        return true;
      }
      return null;
    } catch (e) {
      print("from catch of change phase");
      print(e);
      return null;
    }
  }

  Future<dynamic> editOrder(String id, {Map<String, dynamic> info}) async {
    try {
      http.Response result = await http.put("$endpoint/order/$id",
          body: jsonEncode(info),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      print("from edit order");
      print(result.body);
      if (result.statusCode >= 400) return null;
      return Demande.fromJson(json.decode(result.body));
    } catch (e) {
      print("from edit order catch");
      print(e);
      return null;
    }
  }

  Future<dynamic> getGov() async {
    try {
      http.Response result = await http.get("$endpoint/governorate");
      print("from get gov");

      if (result.statusCode >= 400) return null;
      List<Gov> list = [];
      json.decode(result.body).forEach((f) => list.add(Gov.fromJson(f)));
      return list;
    } catch (e) {
      print("from get gov catch");
      print(e);
      return null;
    }
  }

  // get municipality
  Future<dynamic> getMunicipality(String id) async {
    try {
      http.Response result =
          await http.get("$endpoint/municipality/search?governorate_id=$id");
      print("from get mun");

      if (result.statusCode >= 400) return null;
      List<Municipality> list = [];
      json
          .decode(result.body)
          .forEach((f) => list.add(Municipality.fromJson(f)));
      print(list);
      return list;
    } catch (e) {
      print("from get mun");
      print(e);
      return null;
    }
  }
}
