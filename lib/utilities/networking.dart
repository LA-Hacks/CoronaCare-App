import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.path);

  static final String url = 'http://2c990005.ngrok.io';
  final String path;

  Future getData() async {
    http.Response response = await http.get(url + path);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }

 
  }



