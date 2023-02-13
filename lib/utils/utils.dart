

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:another_flushbar/flushbar_route.dart';

class Utils {

  void changeTextFieldFocus(BuildContext context, FocusNode currentFocus, FocusNode nextFocus){
    currentFocus.unfocus(); // remove focus from current
    FocusScope.of(context).requestFocus(nextFocus); // pass focus to next text field
  }


  void showToastMessage(String message) {
    Fluttertoast.showToast(msg: message); // can decorate it more if you want
  }

  void showErrorFlushBarMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.all(15),
        message: message,
        borderRadius: BorderRadius.circular(20),
        duration: Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: Icon(
          Icons.error,
          size: 28,
          color: Colors.white,
        ),
      )..show(context),
    );
  }

  void showSnackBar(String message, BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),),);
  }
}
