import 'dart:convert';

import 'package:ecommerce_management/main.dart';
import 'package:ecommerce_management/page/product_page.dart';
import 'package:http/http.dart' as http;

import 'package:ecommerce_management/model/product_model.dart';
import 'package:ecommerce_management/util/api.dart';

class ProductServer {
  static Future<List<ProductModel>> getProduct(int page) async {
    if (page == 1) {
      MyApp.l.clear();
    }
    final url = Uri.parse("${Api.getallproduct}?page=$page");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      //List<dynamic> list = json.decode(response.body);
      Map<String, dynamic> m = json.decode(response.body);
      List<ProductModel> l = [];
      if (page > m['last_page']) {
        ProductPage.isLoading = false;
      } else {
        List<dynamic> list = m['data'];

        for (int x = 0; x < list.length; x++) {
          ProductModel model = ProductModel.fromJson(list[x]);

          l.add(model);
        }
        MyApp.l.addAll(l);
        if (page == m['last_page']) {
          ProductPage.isLoading = false;
        }
        MyApp.page += 1;
      }
      ProductPage.pbloc.add(page);

      return l;
    } else {
      return [];
    }
  }

  static Future<List<ProductModel>> searchProduct(String s) async {
    final url = Uri.parse("${Api.serachproduct}/$s");

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
