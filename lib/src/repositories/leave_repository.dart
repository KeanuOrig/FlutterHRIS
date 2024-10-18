import 'dart:convert';
import 'package:hris_mobile_app/src/models/leave.dart';
import 'package:hris_mobile_app/src/api/api_provider.dart';
import 'package:http/http.dart' as http;

class LeaveRepository {
  final ApiProvider apiProvider = ApiProvider();

  Future<List<Leave>> getUser({
    String? startDate,
    String? endDate,
    int? branchId,
    int? departmentId
  }) async {
    final response = await apiProvider.get(
      '/api/v1/user/leaves',
      params: {
        'start_date': startDate,
        'end_date': endDate,
        'branch_id': branchId,
        'department_id': departmentId
      },
    );

    final responseData = jsonDecode(response.body);
    final attendances = Leave.fromJsonList(responseData['data'][0]['attendances']);

    return attendances;
  }

  Future<http.Response> timeIn() async {
    final response = await apiProvider.post(
      '/api/v1/user/attendances/time-in',
      {}
    );
    return response;
  }

  Future<http.Response> timeOut() async {
    final response = await apiProvider.post(
      '/api/v1/user/attendances/time-out',
      {}
    );
    return response;
  }
}
