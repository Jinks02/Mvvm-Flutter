

import 'package:flutter/material.dart';
import 'package:mvvm_flutter/utils/routes/routes_name.dart';

import 'package:mvvm_flutter/view_model/user_view_model.dart';

import '../../model/user_model.dart';

class SplashServices {

  UserViewModel userViewModel = UserViewModel();

  Future<UserModel> getUserData() async{
    return userViewModel.getUserDetails();
  }

  void checkAuth(context) async{

    getUserData().then((value) async {

      debugPrint(value.token);
      if(value.token == 'null' || value.token == ''){
       await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.login);
      }
      else{
       await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.home);
      }

    }).onError((error, stackTrace) {
      debugPrint("error in splash services");
    });

  }

}