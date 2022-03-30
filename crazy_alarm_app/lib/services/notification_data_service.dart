import 'package:crazy_alarm_app/models/notification.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NotificationDataService {
  static const String endpoint = 'http://10.0.2.2:9090/notifications';

  const NotificationDataService();

  Future<List<NotificationConfig>> getNotifications() async {
    List<NotificationConfig> notifications = [];
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for(var notification in jsonResponse){

        notifications.add(NotificationConfig(
            notification['id'],
            notification['title'],
            notification['message'],
            notification['datetime']));
      }
      return notifications;
    } else {
      throw Exception('Error occured');
    }
  }

  Future<int> save(NotificationConfig notification) async {
    // var jsonResponse = null;
    http.Response response = await http.post(Uri.parse(endpoint),headers:<String, String> {
      'Context-Type': 'application/json; charset=UTF-8',
    },body: <String,String> {
      'id':notification.id,
      'title': notification.title,
      'message': notification.message,
      'datetime': notification.datetime
    }
    );
    return response.statusCode;
  }

  Future<int> delete(int id) async {
    final url = Uri.parse(endpoint);
    var response = await http.delete(url,headers:<String, String> {
      'Context-Type': 'application/json; charset=UTF-8',
    },body: <String,String> {
      'id':id.toString()
    });
    if (response.statusCode != 200)
      return Future.error("error: status code ${response.statusCode}");
    return response.statusCode;
  }

  Future<int> update(NotificationConfig notification) async {
    final url = Uri.parse(endpoint);
    var response = await http.patch(url,headers:<String, String> {
      'Context-Type': 'application/json; charset=UTF-8',
    },body: <String,Object> {
      'id':notification.id,
      'title': notification.title,
      'message': notification.message,
      'datetime': notification.datetime    });
    if (response.statusCode != 201)
      return Future.error("error: status code ${response.statusCode}");
    return response.statusCode;
  }
}