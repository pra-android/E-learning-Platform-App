import 'dart:convert';

import 'package:e_learning_platform/services/get_server_key.dart';
import 'package:http/http.dart' as http;

class SendNotificationServices {
  Future<void> sendNotificationsThroughAPi({
    required String? token,
    required String? title,
    required String? body,
    // required Map<String, dynamic> data,
  }) async {
    String serverKey = await GetServerKey().getServeryKey();
    String url =
        "https://fcm.googleapis.com/v1/projects/e-learningapp-ce486/messages:send";

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $serverKey",
    };

    Map<String, dynamic> message = {
      "message": {
        "token": token,
        "notification": {"title": title, "body": body},
        // "data": data,
      },
    };
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(message),
    );
    if (response.statusCode == 200) {
      print("Notifications sent succesfully");
    } else {
      print("Notifications sent failing");
    }
  }
}
