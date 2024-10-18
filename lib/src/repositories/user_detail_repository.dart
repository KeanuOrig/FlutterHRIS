import 'dart:convert';
import 'package:hris_mobile_app/src/models/user_detail.dart';
import 'package:hris_mobile_app/src/api/api_provider.dart';

class UserDetailRepository {
  final ApiProvider apiProvider = ApiProvider();

  Future<UserDetail> getUserInfo() async {
    final response = await apiProvider.get(
      '/api/v1/user/informations'
    );
    
    final responseData = jsonDecode(response.body);
    final userData = UserDetail.fromJson(responseData['data'][0]);

    return userData;
    
  }
}
