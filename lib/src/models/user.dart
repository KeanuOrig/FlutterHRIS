class User {
  final int id;
  final String email;
  final int departmentId;
  final int positionId;
  final int branchId;
  final int statusId;
  final String firstName;
  final String middleName;
  final String lastName;

  User({
    required this.id,
    required this.email,
    required this.departmentId,
    required this.positionId,
    required this.branchId,
    required this.statusId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      departmentId: json['information']['department_id'],
      positionId: json['information']['position_id'],
      branchId: json['information']['branch_id'],
      statusId: json['information']['status_id'],
      firstName: json['information']['first_name'],
      middleName: json['information']['middle_name'],
      lastName: json['information']['last_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'departmentId': departmentId,
      'positionId': positionId,
      'branchId': branchId,
      'statusId': statusId,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
    };
  }
}
//todo: add roles here