

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter/data/app_exceptions.dart';
import 'package:mvvm_flutter/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm_flutter/utils/utils.dart';

class NetworkApiService extends BaseApiServices{

  Utils _utils = Utils();

  @override
  Future getGetApiResponse(String url) async {
    // socket exception is no internet exception
    dynamic responseInJsonFormat;
    try{
      final http.Response response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      responseInJsonFormat = returnJsonResponse(response);
    }
    on SocketException{
      debugPrint('in no internet ');
      throw FetchDataException("No Internet Connection");
    }
    return responseInJsonFormat;
  }

  dynamic returnJsonResponse(http.Response response){

    // handling different status codes
    debugPrint(response.statusCode.toString());
    switch(response.statusCode){
      case 200:
        dynamic responseInJsonFormat = jsonDecode(response.body);
        debugPrint(response.body);
        return responseInJsonFormat;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException('Error occurred with status code ${response.statusCode.toString()}');
    }
  }
  // above 2 functions for get api

  @override
  Future getPostApiResponse(String url,dynamic data) async {
    dynamic responseInJsonFormat;
    try{
      http.Response response= await http.post(Uri.parse(url),
      body: data).timeout(Duration(seconds: 10));


      responseInJsonFormat = returnJsonResponse(response);
    }
    on SocketException{
      _utils.showToastMessage('no internet');
      debugPrint('in no internet ');
      throw FetchDataException("No Internet Connection");
    }
    return responseInJsonFormat;
  }
  
}