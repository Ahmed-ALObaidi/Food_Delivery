import 'package:food_delivery/data/repository/auth_repo.dart';
import 'package:food_delivery/models/response_model.dart';
import 'package:food_delivery/models/signup_body_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService{
  AuthRepo authRepo;
  AuthController({required this.authRepo});
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registeration(SignUpBodyModel signUpBodyModel) async {
    _isLoading = true;
    Response response = await authRepo.registration(signUpBodyModel);
    late ResponseModel responseModel ;
    if(response.statusCode == 200){
      authRepo.saveUserToken(response.body['token']);
      print('Your Token is = '+response.body['token'].toString());
      responseModel = ResponseModel(true, response.body['token']);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String email,String password) async {
    print("Token From Device = ");
    print(authRepo.getUserToken().toString());
    _isLoading = true;
    update();
    Response response = await authRepo.login(email,password);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      print("Token From Backend = ");
      authRepo.saveUserToken(response.body['token']);
      print('Your Token is = '+response.body['token'].toString());
      responseModel = ResponseModel(true, response.body['token']);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  bool userLoggedIn(){
    return  authRepo.userLoggedIn();
  }

  void saveUserNumberAndPassword(String number,String password){
    authRepo.saveUserNumberAndPassword(number, password);
  }
  bool clearSharedData(){
    return authRepo.clearSharedData();
  }
}