// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/user.dart';
import 'package:movies_app_clean_arch/movies/domain/usecase/get_user_usecase.dart';

import '../../../../core/network/app_prefreances.dart';

part 'my_profile_state.dart';

class MyProfileCubit extends Cubit<MyProfileState> {
  MyProfileCubit(this.userUseCase) : super(MyProfileInitial());

  final GetUserUseCase userUseCase;

  void getUserInfo()async{
    try{
      String uid = await AppPrefrenaces().getUid();

      final result = await userUseCase.execute(uid);
      emit(MyProfileSuccess(result));
    }catch (e){
      emit(MyProfileError(e.toString()));
    }
  }

}
