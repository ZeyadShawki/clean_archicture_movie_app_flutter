part of 'register_cubit.dart';

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

