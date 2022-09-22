
import 'package:flutter/material.dart';
import 'package:movies_app_clean_arch/core/utils/enum_movie_state.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {
 final RequestState registerstate;

  RegisterInitial({this.registerstate=RequestState.isLoading});
RegisterInitial copWith({
   RequestState? registerState,
}) {
  return RegisterInitial(registerstate: registerState?? registerstate);
    }


}

