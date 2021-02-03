import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;
  NetworkHelper(this.url);

  Future getData() async {
    try {
      // http.Response response = await http.get(url);
      //they both do the same thing
      var response = await http.get(url);
      if (response.statusCode == 200) {
        String data = response.body;

        var decodedData = jsonDecode(data);
        return decodedData;
      } else {
        print(response.statusCode);
        print(response.reasonPhrase);
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
