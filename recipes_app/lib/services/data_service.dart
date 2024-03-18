import 'package:recipes_app/models/recipe.dart';
import 'package:recipes_app/services/http_service.dart';

class DataService {
  static final DataService _singleton = DataService._internal();

  final HTTPService _httpService = HTTPService();

  factory DataService() {
    return _singleton;
  }

  DataService._internal();

  Future<List<Recipe>?> getRecipes(String filter) async {
    String path = "recipes/";

    if (filter.isNotEmpty) {
      path += "meal-type/$filter";
    }
    
    var response = await _httpService.get(path);

    if (response?.statusCode == 200 && response?.data != null) {
      List data = response!.data["recipes"];
      // We take all the values inside of the list and for each of them, we are going to transform them into a Recipe object
      List<Recipe> recipes = data.map((e) => Recipe.fromJson(e)).toList();
      return recipes;
    }
  }
}