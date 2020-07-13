import 'package:authentification/core/services/api_service.dart';
import 'package:authentification/models/demande.dart';
import 'package:authentification/models/user_model.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import '../../locator.dart';
class MotherModel extends ChangeNotifier {
   dynamic result ;
   List<Demande> demandes ;
  bool load = true ;
  bool bload = true ;
  final _api = locator<ApiService>();
  Future<dynamic> affectClient(String id , String name) async {
    dynamic r = await _api.affectClient(id,name);
    
    notifyListeners();
    return r ;
  } 
  orderGeo(double longitude,double latitude)  {
   affiliates.forEach((f) async {
    print(f.latitude.toString()  + " "+ f.longitude.toString());
    print(latitude.toString() + " " + longitude.toString());
    double distance = await getDistanceFromLonLat(longitude, latitude, f.longitude, f.latitude);
    print(distance);
    f.setDistance(distance);
    print("lena todhher l h9i9aaaaa");
    print(f.distance);
   });
   affiliates.sort((a,b){
     
    return a.distance.compareTo(b.distance) ;
   });
  }
   order(String selon,{double longitude,double latitude}){
     print(selon);

     switch(selon){
       case "Ordre Alphabétique":affiliates.sort((a,b)=>a.affiliate_name.compareTo(b.affiliate_name));break ;
       case "Performance":affiliates.sort((a,b)=>(b.performance.compareTo(a.performance)));break;
       case "Géolocalisation":orderGeo(longitude,latitude) ;break ;
       default : break ; 
     }
     notifyListeners();
   }
   Future<dynamic> deleteOrder(String id,) async {
    load = false ;
    notifyListeners();
    dynamic r = await _api.deleteOrder(id);
    load = true ;
    notifyListeners();
    return r  ;
  } 
   Future<dynamic> addClient(Map<String,dynamic> info,{String cid ,String pid,String aid}) async {
    bload = false ;
    notifyListeners();
    dynamic r = await _api.addOrder(info,cid,pid,aid);
    bload = true ;
    notifyListeners();
    return r;
  } 
  List<Affiliate> affiliates ;
   Future<dynamic> getAffiliates() async {
    load = false ;
    notifyListeners();
    dynamic r = await _api.getAffiliates();
    if(r==null) {
      affiliates = [];
      notifyListeners();
      return [];
    }
    load = true ;
    affiliates = r ;
    notifyListeners();
    return affiliates ;
  } 
  Future<dynamic> getOrders() async {
    load = false ;
    notifyListeners();
    result = await _api.getOrders();
    load = true ;
    if(result!=null) demandes = result;
    notifyListeners();
    return result ;
  }
  Future<double >getDistanceFromLonLat(double longitude1,double latitude1,double longitude2,double latitude2)async{
    
    return   await Geolocator().distanceBetween(longitude1 , latitude1, longitude2 , latitude2);
    
    }
}