// ignore: depend_on_referenced_packages
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies_app_clean_arch/core/utils/enum_movie_state.dart';
import 'package:movies_app_clean_arch/movies/data/models/user_model.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/signin_use_case.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/upload_file_use_case.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/register_cubit/register_state.dart';

import '../../../../core/network/app_prefreances.dart';

class RegisterCubit extends Cubit<RegisterInitial> {
  RegisterCubit(this.signInUseCase, this.uploadFileUseCase) : super(RegisterInitial());
  final SignInUseCase signInUseCase;
  final UploadFileUseCase uploadFileUseCase;
   bool passwordIsHidden=true;
   IconData suffixIcon=Icons.visibility_off;
  void isPasswordHidden(){
    passwordIsHidden=!passwordIsHidden;
    passwordIsHidden?suffixIcon=Icons.visibility_off:suffixIcon=Icons.visibility;
    emit(state.copWith(registerState: RequestState.isLoading));
  }

  void register(UserModel user)async{
    emit(state.copWith(registerState: RequestState.isLoading));
    final resault=await  signInUseCase.execute(user);
    resault.fold((l) {
      emit(state.copWith(registerState: RequestState.isError));
    }, (r)async {
      await AppPrefrenaces().saveUidofUser(r);
      emit(state.copWith(registerState: RequestState.isLoaded));
    });

  }
     File? image;
     String url='';
  Future pickAndUploadImage()async{

     final pick = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pick == null) {
        return ;
      }else{
        final temporery=File(pick.path);
        image=temporery;
        url= await uploadFileUseCase.execute(image as File);

        emit(state.copWith(registerState: RequestState.isLoading));
      }}

}
