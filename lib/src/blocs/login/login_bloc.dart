import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_mobile_app/src/models/user.dart';
import 'package:hris_mobile_app/src/repositories/login_repository.dart';
import 'package:hris_mobile_app/src/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'package:hris_mobile_app/src/constants/app.dart' as constants;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository = LoginRepository();
  final UserRepository userRepository = UserRepository();
  
  static const String tokenKey = 'token';
  static const String userKey = 'user';
  static const Duration apiTimeout = Duration(seconds: 10);
  
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    final prefs = await SharedPreferences.getInstance();
    try {

      final responseLogin = await loginRepository
        .login(username: event.username + constants.emailDomain, password: event.password)
        .timeout(apiTimeout);
  
      if (responseLogin.statusCode == 200) {
        final responseLoginData = jsonDecode(responseLogin.body);
        await prefs.setString(tokenKey, responseLoginData['data']['token']); 
        User responseUserData = await userRepository.getUserInfo();
        await prefs.setString(userKey, jsonEncode(responseUserData));
        emit(LoginSuccess());
      } else {
        final responseLoginData = jsonDecode(responseLogin.body);
        final message = responseLoginData['error']['message'] ?? 'Login failed';
        emit(LoginFailure(message));
      }

    } on TimeoutException {

      emit(const LoginFailure(constants.failedMessage));

    } catch (e) {

      print('Login error: ${e.toString()}');
      emit(LoginFailure(e.toString()));
      
    }
  }
}