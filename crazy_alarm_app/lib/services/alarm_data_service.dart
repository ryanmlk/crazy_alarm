import 'dart:convert';
import 'dart:io';
import 'package:crazy_alarm_app/models/alarm.dart';
import 'package:crazy_alarm_app/constants/util.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AlarmDataService {
  static const String endpoint = apiUrl + alarmRoute;

  const AlarmDataService();

  Future<List<AlarmConfig>> getAlarms() async {
    http.Response response = await http.get(
        Uri.parse(endpoint),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }
    );
    List<AlarmConfig> alarms = [];

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for(var alarm in jsonResponse){

        alarms.add(AlarmConfig(
            alarm['id'],
            alarm['title'],
            alarm['time'],
            alarm['active'],
            alarm['repeat']));
      }
      print(alarms);
      return alarms;
    } 
    else {
      throw Exception('Error occured');
    }
  }

  Future<int> save(AlarmConfig alarm) async {
    // var jsonResponse = null;
    http.Response response = await http.post(
      Uri.parse(endpoint),
      headers:{
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(alarm)
    );
    print(response.statusCode);
    return response.statusCode;
  }

  Future<int> delete(String id) async {
    final url = Uri.parse(endpoint);
    var response = await http.delete(url,headers:<String, String> {
      'Context-Type': 'application/json; charset=UTF-8',
    },body: <String,String> {
      'id':id
    });
    if (response.statusCode != 200)
      return Future.error("error: status code ${response.statusCode}");
    print(response.statusCode);
    return response.statusCode;
  }

  Future<int> update(AlarmConfig alarm) async {
    final url = Uri.parse(endpoint);
    var response = await http.patch(
      url,
      headers:{
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(alarm)
    );
    if (response.statusCode != 201)
      return Future.error("error: status code ${response.statusCode}");
    print(response.statusCode);
    return response.statusCode;
  }
}