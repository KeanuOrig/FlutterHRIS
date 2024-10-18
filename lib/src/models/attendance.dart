class Attendance {
  final int id;
  final int userId;
  final String date;
  final String? timeIn;
  final String? timeOut;
  final String? state;
  final int? location;

  Attendance({
    required this.id,
    required this.userId,
    required this.date,
    required this.timeIn,
    required this.timeOut,
    required this.state,
    required this.location,
  }); 

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      userId: json['user_id'],
      date: json['date'],
      timeIn: json['time_in'],
      timeOut: json['time_out'],
      state: json['state'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date,
      'timeIn': timeIn,
      'timeOut': timeOut,
      'state': state,
      'location': location,
    };
  }
  
  static List<Attendance> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Attendance.fromJson(json)).toList();
  }
}