class UserDetail {
  final int id;
  final String email;
  final String firstName;
  final String middleName;
  final String lastName;
  final int mobileNumber;
  final String position;
  final String birthDate;
  final String hiredDate;
  final String resignedDate;
  final int nationality;
  final int religion;
  final int maritalStatus;
  final String department;
  final String branch;
  final String status;

  UserDetail({
    required this.id,
    required this.email,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.mobileNumber,
    required this.position,
    required this.birthDate,
    required this.hiredDate,
    required this.resignedDate,
    required this.nationality,
    required this.religion,
    required this.maritalStatus,
    required this.department,
    required this.branch,
    required this.status,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      id: json['id'],
      email: json['email'],
      firstName: json['information']['first_name'],
      middleName: json['information']['middle_name'],
      lastName: json['information']['last_name'],
      mobileNumber: json['information']['mobile_number'],
      position: json['information']['position']['name'] ?? '',
      birthDate: json['information']['birth_date'] ?? '',
      hiredDate: json['information']['hired_date'] ?? '',
      resignedDate: json['information']['resigned_date'] ?? '',
      nationality: json['information']['nationality'],
      religion: json['information']['religion'],
      maritalStatus: json['information']['marital_status'],
      department: json['information']['department']['name'] ?? '',
      branch: json['information']['branch']['name'] ?? '',
      status: json['information']['status']['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'mobileNumber': mobileNumber,
      'position': position,
      'birthDate': birthDate,
      'hiredDate': hiredDate,
      'resignedDate': resignedDate,
      'nationality': nationality,
      'religion': religion,
      'maritalStatus': maritalStatus,
      'department': department,
      'branch': branch,
      'status': status,
    };
  }
}
