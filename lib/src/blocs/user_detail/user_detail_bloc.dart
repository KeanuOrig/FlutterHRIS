import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_mobile_app/src/blocs/user_detail/user_detail_event.dart';
import 'package:hris_mobile_app/src/blocs/user_detail/user_detail_state.dart';
import 'package:hris_mobile_app/src/repositories/user_detail_repository.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final UserDetailRepository userDetailRepository = UserDetailRepository();
  
  UserDetailBloc() : super(UserDetailInitial()) {
    on<LoadUserDetail>(_onLoadUserDetail);
  }

  Future<void> _onLoadUserDetail(LoadUserDetail event, Emitter<UserDetailState> emit) async {  
    emit(UserDetailLoading());
    try {
      final userDetail = await userDetailRepository.getUserInfo();
      emit(UserDetailSuccess(userDetail : userDetail));
    } catch (e) {
      emit(UserDetailFailure(e.toString()));
    }


  }
}
