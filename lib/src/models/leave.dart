class Leave {
  final int id;
  final int userId;
  final int? approverId;
  final String startDate;
  final String reason;
  final String endDate;  
  final bool halfDay;  
  final bool postMeridiem;  
  final int status;
  final String statusDesc;
  final bool type;
  final String typeDesc;
  final int initialApprover;

  Leave({
    required this.id,
    required this.userId,
    required this.approverId,
    required this.startDate,
    required this.reason,
    required this.endDate,
    required this.halfDay,
    required this.postMeridiem,
    required this.status,
    required this.statusDesc,
    required this.type,
    required this.typeDesc,
    required this.initialApprover,
  }); 

  factory Leave.fromJson(Map<String, dynamic> json) {
    return Leave(
      id: json['id'],
      userId: json['user_id'],
      approverId: json['approver_id'],
      startDate: json['start_date'],
      reason: json['reason'],
      endDate: json['end_date'],
      halfDay: json['half_day'],
      postMeridiem: json['post_meridiem'],
      status: json['status'],
      statusDesc: json['status_desc'],
      type: json['type'],
      typeDesc: json['type_desc'],
      initialApprover: json['initial_approver'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'approverId': approverId,
      'startDate': startDate,
      'reason': reason,
      'endDate': endDate,
      'halfDay': halfDay,
      'postMeridiem': postMeridiem,
      'status': status,
      'statusDesc': statusDesc,
      'type': type,
      'typeDesc': typeDesc,
      'initialApprover': initialApprover,
    };
  }
  
  static List<Leave> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Leave.fromJson(json)).toList();
  }
}