import '../../../model/login_model.dart';

abstract class AuthStates {}

class AuthInitializedStates extends AuthStates {}

// start logic for login------------------

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends AuthStates {
  final String msg;

  LoginErrorState(this.msg);
}
