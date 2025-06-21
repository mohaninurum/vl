import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:visual_learning/constant/api_url/ApiUrls.dart';

class ApiService {
  final String baseUrl = ApiUrls.baseUrl;
  Future<Map<String, dynamic>> get(String endpoint, Map<String, dynamic> body) async {
    try {
      final String token = body['auth'] ?? '';
      final Uri uri = Uri.parse(endpoint);

      final headers = {'Content-Type': 'application/json; charset=UTF-8', if (token.isNotEmpty) 'Authorization': 'Bearer $token'};

      print("GET Endpoint: $uri");
      print("Token: $token");

      final response = await http.get(uri, headers: headers).timeout(const Duration(seconds: 30));

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      final decoded = jsonDecode(response.body);

      if ([200, 201, 400, 401, 404, 500].contains(response.statusCode)) {
        return decoded;
      } else {
        throw Exception('Unhandled status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error during GET request: $e");
      throw Exception('Failed to load data: $e');
    }
  }
  // Future<Map<String, dynamic>> get(String endpoint, Map<String, dynamic> body) async {
  //   // {'Content-Type': 'application/json'}
  //   print(endpoint);
  //   print(body);
  //   final token = body.containsKey('auth') ? body['auth'] : '';
  //   print(token);
  //
  //   final response = await http.get(Uri.parse('$baseUrl$endpoint'), headers: token.isEmpty ? {'Content-Type': 'application/json; charset=UTF-8'} : {'Authorization': 'Bearer $token', 'Content-Type': 'application/json; charset=UTF-8'});
  //   print("Get API Responce status code:-${response.statusCode}");
  //   print("Get API Responce:-${response.body}");
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else if (response.statusCode == 201) {
  //     return jsonDecode(response.body);
  //   } else if (response.statusCode == 400) {
  //     return jsonDecode(response.body);
  //   } else if (response.statusCode == 401) {
  //     return jsonDecode(response.body);
  //   } else if (response.statusCode == 404) {
  //     return jsonDecode(response.body);
  //   } else if (response.statusCode == 500) {
  //     return jsonDecode(response.body);
  //   } else {
  //     return throw Exception('Failed to load data');
  //   }
  // }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    print(endpoint);
    print(body);
    final token = body.containsKey('auth') ? body['auth'] : '';
    final response = await http.post(Uri.parse(endpoint), headers: token.isEmpty ? {'Content-Type': 'application/json; charset=UTF-8'} : {'Authorization': 'Bearer $token', 'Content-Type': 'application/json; charset=UTF-8'}, body: jsonEncode(body)).timeout(const Duration(seconds: 30));
    print("Post API Responce status code:-${response.statusCode}");
    print("post API Responce:-${response.body}");
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      return jsonDecode(response.body);
    } else {
      return throw Exception('Failed to load data');
    }
  }
}
