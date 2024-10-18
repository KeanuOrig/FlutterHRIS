import 'package:equatable/equatable.dart';
import 'package:hris_mobile_app/src/models/user_detail.dart';

abstract class UserDetailState extends Equatable {
  const UserDetailState();

  @override
  List<Object?> get props => [];
}

class UserDetailInitial extends UserDetailState {}

class UserDetailLoading extends UserDetailState {}

class UserDetailSuccess extends UserDetailState {
  final UserDetail userDetail;
  const UserDetailSuccess({required this.userDetail});
}  

class UserDetailFailure extends UserDetailState {
  final String message;

  const UserDetailFailure(this.message);

  @override
  List<Object?> get props => [message];
}

//Todo: copyWith