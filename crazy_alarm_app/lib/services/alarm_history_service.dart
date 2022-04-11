import 'package:crazy_alarm_app/models/alarm_history.dart';
import 'package:crazy_alarm_app/models/notification.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AlarmHistoryService {
  static const String endpoint =
      'https://crazy-alarm-api.herokuapp.com/alarmHistory';

  const AlarmHistoryService();

  Future<List<AlarmHistory>> getAlarmHistory() async {
    List<AlarmHistory> alarmHistoryList = [];
    try {
      final response = await http.get(Uri.parse(endpoint));

      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        for (var alarmHistory in jsonResponse) {
          alarmHistoryList.add(AlarmHistory(
              alarmHistory['id'], alarmHistory['day'], alarmHistory['time']));
        }
        return alarmHistoryList;
      } else {
        throw Exception('Error occured');
      }
    } catch (error) {
      throw Error();
    }
  }

  Future<int> save(AlarmHistory alarmHistory) async {
    // var jsonResponse = null;
    http.Response response =
        await http.post(Uri.parse(endpoint), headers: <String, String>{
      'Context-Type': 'application/json; charset=UTF-8',
    }, body: <String, String>{
      'id': alarmHistory.id,
      'day': alarmHistory.day,
      'time': alarmHistory.time
    });
    return response.statusCode;
  }

  Future<int> delete(int id) async {
    final url = Uri.parse(endpoint);
    var response = await http.delete(url, headers: <String, String>{
      'Context-Type': 'application/json; charset=UTF-8',
    }, body: <String, String>{
      'id': id.toString()
    });
    if (response.statusCode != 200) {
      return Future.error("error: status code ${response.statusCode}");
    }
    return response.statusCode;
  }

  Future<int> update(AlarmHistory alarmHistory) async {
    final url = Uri.parse(endpoint);
    var response = await http.patch(url, headers: <String, String>{
      'Context-Type': 'application/json; charset=UTF-8',
    }, body: <String, Object>{
      'id': alarmHistory.id,
      'day': alarmHistory.day,
      'time': alarmHistory.time
    });
    if (response.statusCode != 201) {
      return Future.error("error: status code ${response.statusCode}");
    }
    return response.statusCode;
  }
}
