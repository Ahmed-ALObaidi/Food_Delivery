import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get.dart';

import '../data/repository/recommended_product_repo.dart';

class RecommendedProductController extends GetxController{
  RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});

  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getRecommendedProductList()async {
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode == 200){
      print('Success');
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      print(_recommendedProductList);
      _isLoading = true;
      update();
    } else {
      print("Doesn't Success *");
      print(response.statusCode.toString());
    }
  }
}