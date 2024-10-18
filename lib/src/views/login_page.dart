import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_mobile_app/routes.dart';
import 'package:hris_mobile_app/src/blocs/login/login_bloc.dart';
import 'package:hris_mobile_app/src/blocs/login/login_event.dart';
import 'package:hris_mobile_app/src/blocs/login/login_state.dart';
import 'package:hris_mobile_app/src/components/loading_screen.dart';
import 'package:hris_mobile_app/src/controllers/login_controller.dart';
import 'package:hris_mobile_app/src/components/custom_text_field.dart';
import 'package:hris_mobile_app/src/components/custom_snackbar.dart';
import 'package:hris_mobile_app/src/constants/app.dart' as constants;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  late final LoginController loginController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    loginController = LoginController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/hipe-logo-black.png'),
              const SizedBox(height: 20.0),
              CustomTextField(
                controller: usernameController,
                labelText: 'Username',
                suffixText: constants.emailDomain,
              ),
              const SizedBox(height: 10.0),
              CustomTextField(
                controller: passwordController,
                labelText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    Navigator.pushReplacementNamed(context, Routes.home);
                  } else if (state is LoginFailure) {
                    CustomSnackBar.show(
                      context,
                      text: state.message,
                      backgroundColor: Colors.red,
                    );
                  }
                },
                builder: (context, state) {
                  return state is LoginLoading
                      ? const LoadingScreen()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                          onPressed: () {
                            if (_validateFields(context)) {
                              context.read<LoginBloc>().add(
                                LoginSubmitted(
                                  usernameController.text,
                                  passwordController.text,
                                ),
                              );
                            }
                          },
                          child: const Text('Login'),
                        );
                },
              ),
              const SizedBox(height: 30),
              const Text('Forgot Password?'), // todo: integrate forgot password
            ],
          ),
        ),
      ),
    );
  }

  bool _validateFields(BuildContext context) {
    final isValidUsername = loginController.validateUsername(usernameController.text);
    final isValidPassword = loginController.validatePassword(passwordController.text);

    if (isValidUsername != null || isValidPassword != null) {
      CustomSnackBar.show(
        context,
        text: isValidUsername ?? isValidPassword!,
        backgroundColor: Colors.grey,
      );
      return false;
    }
    return true;
  }
}