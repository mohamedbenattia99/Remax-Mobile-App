import 'package:authentification/core/services/api_service.dart';
import 'package:authentification/locator.dart';
import 'package:authentification/models/demande.dart';
import 'package:flutter/widgets.dart';

class SubModel extends ChangeNotifier {
  dynamic result ;
  List<Demande> demandes ;
  bool load = true ;
  bool listload =true ;
  final _api = locator<ApiService>();
  Future<dynamic> deleteOrder(String id) async {
    load = false ;
    notifyListeners();
    dynamic r = await _api.deleteOrder(id);
    load = true ;
    notifyListeners();
    return r ;
  } 
  Future<dynamic> getOrders(id) async {
    listload = false ;
    notifyListeners();
    result = await _api.getAffiliateOrders(id);
    listload = true ;
    if(result!=null) demandes = result ;
    notifyListeners();
    return result ;
  } 
  Future<dynamic> changePhase(id,newPhase) async {
    load = false ;
    notifyListeners();
    result = await _api.changePhase(id,newPhase);
    load = true ;
    notifyListeners();
    return result;
  } 
  Future<dynamic> affectAgent(id,agent) async {
    load = false ;
    notifyListeners();
    dynamic r = await _api.affectAgent(id,agent);
    load = true ;
    notifyListeners();
    return r ;
  }
 
}