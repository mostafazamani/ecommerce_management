import 'dart:convert';

import 'package:ecommerce_management/model/category_model.dart';
import 'package:ecommerce_management/util/api.dart';
import 'package:http/http.dart' as http;

class CategoryServer {
  static Future<List<CategoryModel>> getCategory() async {
    final url = Uri.parse(Api.getallcategory);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(response.body);
      List<CategoryModel> l = [];

      for (int x = 0; x < list.length; x++) {
        CategoryModel model = CategoryModel.fromJson(list[x]);

        l.add(model);
      }
      return l;
    } else {
      return [];
    }
  }

  static Future<bool> addCategory(String name) async {
    final url = Uri.parse(Api.addcategory);

    final response = await http.post(
      url,
      body: {
        'name': name,
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteCategory(CategoryModel cat) async {
    final url = Uri.parse(Api.deletecategory);

    final response = await http.post(
      url,
      body: {
        'id': cat.id.toString(),
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
