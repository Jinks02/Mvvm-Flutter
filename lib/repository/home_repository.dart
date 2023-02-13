import '../data/network/base_api_services.dart';
import '../data/network/network_api_service.dart';
import '../model/dummy_json_api_response_model.dart';
import '../res/app_urls.dart';

class HomeRepository {


  BaseApiServices _apiServices = NetworkApiService();

  Future<DummyJsonApiResponseModel> fetchDataFromDummyJson () async{
    try{
      dynamic response = await _apiServices.getGetApiResponse(AppUrls.dummyJsonProductsUrl);
      return response = DummyJsonApiResponseModel.fromJson(response); // returns response in json format
    }
    catch(e){
      throw e;
    }
  }

}