import 'package:hris_mobile_app/src/api/api_provider.dart';
import 'package:http/http.dart' as http;

class LoginRepository {
  final ApiProvider apiProvider = ApiProvider();

  Future<http.Response> login({required String username, required String password}) async {
    return await apiProvider.post(
      '/api/v1/auth/login',
      {'email': username, 'password': password},
    );
  }
}
