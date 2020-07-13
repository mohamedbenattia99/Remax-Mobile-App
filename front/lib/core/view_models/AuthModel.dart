import 'package:authentification/core/services/auth_service.dart';
import 'package:authentification/locator.dart';
import 'package:flutter/widgets.dart';
class AuthModel extends ChangeNotifier {
  AuthService auth = locator<AuthService>();
  bool load = true ;
  dynamic result ;
  signUpClient(info) async {
    print("from auh model affiliate signup ---------");
    load = false ;
    notifyListeners();
     result = await auth.clientSignup(info);
    load = true ;
    notifyListeners();
    return result ;
  }
  signUpAffiliate(info) async {
    print("from auh model affiliate signup ---------");
    load = false ;
    notifyListeners();
    result = await auth.affiliateSignup(info);
    
    load = true ;
    notifyListeners();
    return result ;
  }
  login(email,password) async {
    
    load = false ;
    notifyListeners();
     result = await auth.login(email, password);
    load = true ;
    print("from login model ");
    print(result);
    notifyListeners();
    return result ;
  }
  autoLogin() async {
    load = false ;
    notifyListeners();
    result = await auth.autoLogin();
    load = true ;
    notifyListeners();
    return result ;
  }


}