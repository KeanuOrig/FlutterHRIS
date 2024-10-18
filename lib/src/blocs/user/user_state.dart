import 'package:equatable/equatable.dart';
import 'package:hris_mobile_app/src/models/user.dart';

class UserState extends Equatable {
  final User? user;

  const UserState({this.user});

  factory UserState.fromJson(Map<String, dynamic> json) {
    return UserState(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
    };
  }

  @override
  List<Object?> get props => [user];
}