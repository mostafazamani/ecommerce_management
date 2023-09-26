import 'dart:convert';

import 'package:ecommerce_management/model/user_model.dart';
import 'package:ecommerce_management/util/api.dart';
import 'package:http/http.dart' as http;

class UserServer {
  static Future<List<UserModel>> getuser() async {
    Uri uri = Uri.parse(Api.getusers);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      List<dynamic> list = json.decode(response.body);

      List<UserModel> l = [];
      for (var i = 0; i < list.length; i++) {
        UserModel user = UserModel.fromJson(list[i]);
        l.add(user);
      }

      return l;
    } else {
      throw Exception('failed load data');
    }
  }

  static Future<UserModel> getuserwithemail(String email) async {
    final url = Uri.parse(Api.getuserwithemail);

    final response = await http.post(
      url,
      body: {
        'email': email,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      UserModel model = UserModel.fromJson(map);

      return model;
    } else {
      throw ("wrong");
    }
  }
}
