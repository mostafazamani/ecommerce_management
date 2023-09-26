import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:ecommerce_management/model/product_model.dart';
import 'package:ecommerce_management/util/api.dart';

class ProductServer {
  static Future<List<ProductModel>> getProduct() async {
    final url = Uri.parse(Api.getallproduct);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(response.body);
      List<ProductModel> l = [];

      for (int x = 0; x < list.length; x++) {
        ProductModel model = ProductModel.fromJson(list[x]);

        l.add(model);
      }
      return l;
    } else {
      return [];
    }
  }

  static Future<bool> addProduct(ProductModel p) async {
    final url = Uri.parse(Api.addproduct);

    final response = await http.post(
      url,
      body: {
        'name': p.name,
        'price': p.price,
        'discount': p.discont,
        'pricediscount': p.disprice,
        'details': p.details,
        'available': p.available.toString(),
        'category': p.category,
        'image': p.image,
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateProduct(ProductModel p) async {
    final url = Uri.parse(Api.updateproduct);

    final response = await http.post(
      url,
      body: {
        'id': p.id,
        'name': p.name,
        'price': p.price,
        'discount': p.discont,
        'pricediscount': p.disprice,
        'details': p.details,
        'available': p.available.toString(),
        'category': p.category,
        'image': p.image,
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteProduct(ProductModel p) async {
    final url = Uri.parse(Api.deleteproduct);

    final response = await http.post(
      url,
      body: {
        'id': p.id,
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
