
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




import '../../../model/login_model.dart';

import '../../database/network/dio_helper.dart';
import '../../database/network/end_points.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitializedStates());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  LoginModel? loginModel;
  bool isPasswordLogin =true;
  Future<void> userLogin({
    required String userName,
    required String password,

  }) async {
    emit(LoginLoadingState());
    await DioHelper.postData(url: login, data: {
      'email': userName,
      'password': password,

    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((onError) {
      if (onError is DioError) {

        emit(LoginErrorState(
            onError is DioError ? onError.response!.data['message'] : 'Error'));
      }
    });
  }










}
