import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  ApiProvider() {
    dotenv.load(fileName: ".env");
  }

  // Get Requests
  Future<http.Response> get(String endpoint, {
    Map<String, dynamic>? params,
    Map<String, String>? customHeaders
  }) async {
  
    // Convert params to string
    Map<String, String> queryParams = {};
    if (params != null) {
      params.forEach((key, value) {
        queryParams[key] = value.toString();
      });
    }

    final Uri uri = Uri.parse('${dotenv.env['API_BASE_URL']}$endpoint').replace(queryParameters: queryParams);
    final response = await http.get(  
      uri,
      headers: await _mergeHeaders(customHeaders),
    );

    return response;
  }

  // Post Requests
  Future<http.Response> post(String endpoint, Map<String, String> body, {Map<String, String>? customHeaders}) async {
    final url = Uri.parse('${dotenv.env['API_BASE_URL']}$endpoint');

    final response = await http.post(
      url,
      headers: await _mergeHeaders(customHeaders),
      body: jsonEncode(body),
    );

    return response;
  }

  // Patch Requests
  Future<http.Response> patch(String endpoint, Map<String, String> body, {Map<String, String>? customHeaders}) async {
    final url = Uri.parse('${dotenv.env['API_BASE_URL']}$endpoint');

    final response = await http.patch(
      url,
      headers: await _mergeHeaders(customHeaders),
      body: jsonEncode(body),
    );

    return response;
  }

  // Put Requests
  Future<http.Response> put(String endpoint, Map<String, String> body, {Map<String, String>? customHeaders}) async {
    final url = Uri.parse('${dotenv.env['API_BASE_URL']}$endpoint');

    final response = await http.put(
      url,
      headers: await _mergeHeaders(customHeaders),
      body: jsonEncode(body),
    );

    return response;
  }

  // Delete Requests
  Future<http.Response> delete(String endpoint, {Map<String, String>? customHeaders}) async {
    final url = Uri.parse('${dotenv.env['API_BASE_URL']}$endpoint');

    final response = await http.delete(
      url,
      headers: await _mergeHeaders(customHeaders),
    );

    return response;
  }

  // Helper function to merge headers and add bearer token
  Future<Map<String, String>> _mergeHeaders(Map<String, String>? customHeaders) async {

    final defaultHeaders = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      defaultHeaders['Authorization'] = 'Bearer $token';
    }

    if (customHeaders == null) {
      return defaultHeaders;
    }

    return {...defaultHeaders, ...customHeaders};
  }
}
