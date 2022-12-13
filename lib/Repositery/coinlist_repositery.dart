
import 'package:blocmvvm/data/Network/base_api_service.dart';
import 'package:blocmvvm/data/Network/network_api_service.dart';

import '../Model/coin_model.dart';

class HomeRepository {

  BaseApiServices _apiServices = NetworkApiService();


  Future<CoinModel> fetchMovies()async{
    
    try {
      dynamic response = await _apiServices.getGetApiResponse("");
      return response = CoinModel.fromJson(response);
      
    }catch(e,stack){
      print("e> "+e.toString());
      print("e> "+stack.toString());
      rethrow;
    }
  }

}