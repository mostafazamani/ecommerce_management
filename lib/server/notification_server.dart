import 'package:http/http.dart' as http;

import 'package:ecommerce_management/util/api.dart';

class NotifServer {
  static Future<bool> SendToAll(String title, String msg) async {
    final url = Uri.parse(Api.notification);

    String raw =
        '{ "notification":{"title":"$title","body":"$msg"}, "to":"/topics/all"}';
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAA6mBD9zA:APA91bGnmDXfbs1UfaskIVOkrNshVRB09bML_av6LmPd74WWhoRJ2Jw8j-ilVavfTQz2-RJ8JT4Ygbl-JmmcRU4dI1l3GI_LYXGVATLbvgOalYijCPcWu04O-7NGICG0803WBy3Xa_IP'
        },
        body: raw);

    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> SendToUser(String title, String msg, String fcm) async {
    final url = Uri.parse(Api.notification);

    String raw =
        '{ "notification":{"title":"$title","body":"$msg"}, "to":"$fcm"}';
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAA6mBD9zA:APA91bGnmDXfbs1UfaskIVOkrNshVRB09bML_av6LmPd74WWhoRJ2Jw8j-ilVavfTQz2-RJ8JT4Ygbl-JmmcRU4dI1l3GI_LYXGVATLbvgOalYijCPcWu04O-7NGICG0803WBy3Xa_IP'
        },
        body: raw);

    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
