import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/models/signup_body_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.sharedPreferences, required this.apiClient});

  Future<Response> registration(SignUpBodyModel signUpBodyModel) async {
    return await apiClient.post(
        AppConstants.REGISTRATION_URI, signUpBodyModel.toJson());
  }

  Future<Response> login(String email, String password) async {
    return await apiClient.post(
        AppConstants.LOGIN_URI, {"email": email, "password": password});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  bool userLoggedIn(){
    return  sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<String> getUserToken()async{
    return await sharedPreferences.getString(AppConstants.TOKEN) ?? "NONE";
  }
  Future<void> saveUserNumberAndPassword(String number,String password)async{
    try{
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(e){
      throw e;
    }
  }
  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    sharedPreferences.remove(AppConstants.TOKEN);
    apiClient.token='';
    apiClient.updateHeader("");
    return true;
  }
}
