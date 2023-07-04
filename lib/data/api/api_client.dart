import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constants.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeader;
  late SharedPreferences sharedPreferences;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    // print(sharedPreferences.getString(AppConstants.TOKEN).toString()+'   TTTThis is Fuckeennn TTTTTOOOOOOOOOOKKKKKKKKKEEEEENNNN');
    token = sharedPreferences.getString(AppConstants.TOKEN)??AppConstants.TOKEN;
    _mainHeader = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      // 'Accept': 'application/json',
    };
  }

  Future<Response> getData(String uri, {Map<String,String>? headers}) async {
    try {
      Response response = await get(uri,
      headers: headers??_mainHeader,
      );
      return response;
    } catch (e) {
      return Response(statusCode: 1,statusText: e.toString());
    }
  }
  void updateHeader(String token){
    _mainHeader = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      // 'Accept': 'application/json',
  };
  }
  Future<Response> postData(String uri,dynamic body) async {
    print("$body this is body");
    try{
      Response response = await post(uri, body,headers: _mainHeader);
      print("$response this is Response");
      return response;
    }catch(e){
      print('TEST ${e.toString()}');
      return Response(statusText: e.toString(),statusCode: 1);
    }
  }

}
