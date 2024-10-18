import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'user_state.dart';
import 'package:hris_mobile_app/src/repositories/user_repository.dart';

// TBC : HydratedBloc persist states even on app restart. Todo, apply this to parts of this app.
class UserCubit extends HydratedCubit<UserState> {
  final UserRepository userRepository;

  UserCubit(this.userRepository) : super(const UserState());

  Future<void> getUserInfo() async {
    try {
      final userData = await userRepository.getUserInfo();
      if (state.user != userData) {
        emit(UserState(user: userData));
      }
    } catch (error) {
      print("Error fetching user info: $error");
    }
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    return UserState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    return state.toJson();
  }
}
