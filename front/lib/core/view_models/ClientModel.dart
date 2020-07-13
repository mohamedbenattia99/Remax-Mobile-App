import 'package:authentification/core/services/api_service.dart';
import 'package:authentification/models/demande.dart';
import 'package:flutter/widgets.dart';

import '../../locator.dart';

class ClientModel extends ChangeNotifier {
   dynamic result ;
  bool load = true ;
  bool codeLoad = false ;
     List<Demande> demandes ;

  final _api = locator<ApiService>();
 
  Future<dynamic> getOrderByCode(code) async{
    codeLoad = false ;
    notifyListeners();
    result =  await _api.getOrderByCode(code);
    codeLoad = true ;
    notifyListeners();
  }
   Future<dynamic> affectClientId(cid,id) async{
    codeLoad = false ;
    notifyListeners();
    result =  await _api.affectClientId(cid,id);
    codeLoad = true ;
    notifyListeners();
    return result ;
  }
  Future<dynamic> getOrders(id) async {
    load = false ;
    notifyListeners();
    result = await _api.getClientOrders(id);
    load = true ;
        if(result!=null) demandes = result;

    notifyListeners();
  }
}