import 'dart:io';

import 'package:http/http.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../constants.dart';

class UserService{

  String url;

  UserService({required this.url});

  Future<Map> userSignUp(Map user) async{
    print (user);
    Uri requestUrl = Uri.parse('$apiUrl/$url');
    Response response = await post(
      requestUrl,
      body: jsonEncode(user),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      }
    );
    Map data = jsonDecode(response.body);
    return data;
  }

  Future<Map> userLogin(Map user) async{
    Uri requestUrl = Uri.parse('$apiUrl/$url');
    Response response = await post(
      requestUrl,
      body: jsonEncode(user),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      }
    );
    Map data = jsonDecode(response.body);
    Map userData = data['user'];
    String token = data['token'];
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    if(userData['logged']){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('loggedUser', userData['id']);
      prefs.setBool('isLogged', true);
    }
    return data;
  }

  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool("isLogged")==null){
      return false;
    }else if(prefs.getBool("isLogged")==true){
      return true;
    }else{
      return false;
    }
  }

  Future<Map> getUserById(String userId) async{
    Uri requestUrl = Uri.parse('$apiUrl/$url/$userId');
    Response response = await get(
        requestUrl,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }
    );
    Map data = jsonDecode(response.body);
    print(data);
    return data;
  }
  Future<Map> deleteUserById(String userId) async{
    Uri requestUrl = Uri.parse('$apiUrl/$url/$userId');
    Response response = await get(
        requestUrl,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }
    );
    Map data = jsonDecode(response.body);
    print(data);
    return data;
  }

  Future<Map> updateUser(Map user) async {
    Uri requestUrl = Uri.parse('$apiUrl/$url');
    Response response = await put(
        requestUrl,
        body: jsonEncode(user),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }
    );
    Map data = jsonDecode(response.body);
    return data;
  }
}