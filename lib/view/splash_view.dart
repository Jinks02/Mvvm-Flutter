import 'package:flutter/material.dart';
import 'package:mvvm_flutter/view_model/services/splash_services.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {


  SplashServices splashServices =SplashServices();
  @override
  void initState() {
    splashServices.checkAuth(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Text("splash Screen"),
        )
      ),
    );
  }
}
