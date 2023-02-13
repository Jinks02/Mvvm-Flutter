import 'package:flutter/cupertino.dart';
import 'package:mvvm_flutter/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier{

  Future<bool> saveUserDetails (UserModel user) async{

    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.token.toString());
    notifyListeners();
    return true;

  }

  Future<UserModel> getUserDetails () async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');

    return UserModel(
      token: token.toString()
    );
  }

  Future<bool> removeUserDetailsOnLogout() async{

    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.clear();
    // sp.remove('token');
    // return true;
  }


}