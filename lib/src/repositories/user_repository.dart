import 'dart:convert';
import 'package:hris_mobile_app/src/models/user.dart';
import 'package:hris_mobile_app/src/api/api_provider.dart';

class UserRepository {
  final ApiProvider apiProvider = ApiProvider();

  Future<User> getUserInfo() async {
    final response = await apiProvider.get(
      '/api/v1/auth/me'
    );
  
    final responseData = jsonDecode(response.body);
    final userData = User.fromJson(responseData['data']);

    return userData;
    
  }
}
