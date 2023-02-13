





import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter/utils/routes/routes_name.dart';
import 'package:mvvm_flutter/view/home_view.dart';
import 'package:mvvm_flutter/view/login_view.dart';
import 'package:mvvm_flutter/view/sign_up_view.dart';

import '../../view/splash_view.dart';

class Routes{

  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => HomeView());

      case RoutesName.login:
        return MaterialPageRoute(builder: (context)=> LoginView());

      case RoutesName.signUp:
        return MaterialPageRoute(builder: (context)=> SignUpView());

      case RoutesName.splash:
        return MaterialPageRoute(builder: (context)=> SplashView());
      default:
        return MaterialPageRoute(builder: (context){
          return const Scaffold(
            body: Center(
              child: Text("no route defined"),
            ),
          );
        });
    }

  }
}