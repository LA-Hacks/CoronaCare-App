import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.path);

  static final String url = 'http://2c990005.ngrok.io';
  final String path;
  static String accessKey = "";
  static String username;
  static String type;

  Future login(String uname, String password) async {
    final http.Response response = await http.post(
      url + path,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({"username": uname, "password": password}),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      type = data['type'];
      accessKey = "Bearer " + data['access_token'];
      username = uname;
      print(accessKey);
      print(type);
      return data['type'];
    } else {
      throw Exception('Failed to login.');
    }
  }

  Future getData() async {
    http.Response response = await http
        .get(url + path, headers: <String, String>{"Authorization": accessKey});

    if (response.statusCode < 300) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }

  Future sendData(Map json) async {
    final http.Response response = await http.post(
      url + path,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": accessKey
      },
      body: jsonEncode(json),
    );
    print(response.body);

    if (response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
