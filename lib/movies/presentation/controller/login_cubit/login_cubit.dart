// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:movies_app_clean_arch/core/network/app_prefreances.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginUseCase) : super(LoginInitialState());
  final LoginUseCase loginUseCase;

  bool passwordIsHidden=true;
  IconData suffixIcon=Icons.visibility_off;
  void isPasswordHidden(){
    emit(LoginLoadingState());
    passwordIsHidden=!passwordIsHidden;
    passwordIsHidden?suffixIcon=Icons.visibility_off:suffixIcon=Icons.visibility;
    emit(LoginpasswordchangeState());
  }

  void login(String email,String password)async{
      emit(LoginLoadingState());
     final resault=await loginUseCase.execute(email, password);
     resault.fold((l) {

       }, (r)async {
       await AppPrefrenaces().saveUidofUser(r);
       emit(LoginSuccessState());
     });

  }

}
