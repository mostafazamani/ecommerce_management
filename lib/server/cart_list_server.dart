import 'dart:convert';

import 'package:ecommerce_management/model/cart_list_model.dart';
import 'package:ecommerce_management/model/product_model.dart';
import 'package:ecommerce_management/util/api.dart';
import 'package:http/http.dart' as http;

class CartServer {
  static Future<List<CartListModel>> getCartList() async {
    final url = Uri.parse(Api.getcartlist);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(response.body);
      List<CartListModel> l = [];

      for (int x = 0; x < list.length; x++) {
        CartListModel model = CartListModel.fromJson(list[x]);
        l.add(model);
      }
      return l;
    } else {
      return [];
    }
  }

  static Future<ProductModel> itemdetails(String id) async {
    final url = Uri.parse(Api.itemcartdetails);

    final response = await http.post(
      url,
      body: {
        'id': id,
      },
    );

    if (response.statusCode == 200) {
      ProductModel model = ProductModel.fromJson(json.decode(response.body));
      return model;
    } else {
      throw ("error");
    }
  }
}
