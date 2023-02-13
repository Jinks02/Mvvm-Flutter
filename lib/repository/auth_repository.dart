import 'package:mvvm_flutter/data/network/base_api_services.dart';
import 'package:mvvm_flutter/data/network/network_api_service.dart';
import 'package:mvvm_flutter/res/app_urls.dart';

class AuthRepository{

  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginReqresApi (dynamic dataToBeProvided) async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrls.reqresLoginUrl, dataToBeProvided);
      return response;
    }
    catch(e){
      throw e;
    }
  }

  Future<dynamic> registerReqresApi (dynamic dataToBeProvided) async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrls.reqresRegisterURL, dataToBeProvided);
      return response;
    }
    catch(e){
      throw e;
    }
  }
}