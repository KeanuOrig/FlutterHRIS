import 'dart:convert';
import 'package:hris_mobile_app/src/api/api_provider.dart';
import 'package:http/http.dart' as http;

class AttendanceRepository {
  final ApiProvider apiProvider = ApiProvider();

  Future<List<dynamic>> getUserAttendance({
    String? startDate,
    String? endDate,
    int? branchId,
    int? departmentId
  }) async {
    final response = await apiProvider.get(
      '/api/v1/user/attendances',
      params: {
        'start_date': startDate,
        'end_date': endDate,
        'branch_id': branchId,
        'department_id': departmentId
      },
    );

    final responseData = jsonDecode(response.body);
    return responseData['data'];
  }

  Future<http.Response> timeIn() async {
    return await apiProvider.post('/api/v1/user/attendances/time-in', {});
  }

  Future<http.Response> timeOut() async {
    return await apiProvider.post('/api/v1/user/attendances/time-out', {});
  }
}
