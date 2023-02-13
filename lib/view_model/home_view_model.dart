import 'package:flutter/material.dart';
import 'package:mvvm_flutter/data/response/api_response.dart';
import 'package:mvvm_flutter/model/dummy_json_api_response_model.dart';
import 'package:mvvm_flutter/repository/home_repository.dart';

class HomeViewModel with ChangeNotifier{

  final _homeRepository = HomeRepository();

  ApiResponse<DummyJsonApiResponseModel> productsList = ApiResponse.loading();

  void setProductsList (ApiResponse<DummyJsonApiResponseModel> response){
    productsList = response;
    notifyListeners();
  }


  Future<void> fetchProductsListFromDummyJsonApi()async {

    setProductsList(ApiResponse.loading());
    _homeRepository.fetchDataFromDummyJson().then((value) {
      setProductsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      debugPrint("in error of homeviewmodel");
      debugPrint(error.toString());
      setProductsList(ApiResponse.error(error.toString()));
    });
  }

}