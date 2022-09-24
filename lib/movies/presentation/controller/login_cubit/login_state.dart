part of 'login_cubit.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {

}
class LoginpasswordchangeState extends LoginState{

}
class LoginLoadingState extends LoginState{

}
class LoginSuccessState extends LoginState{

}

class LoginErrorState extends LoginState{
final String message;

  LoginErrorState(this.message);

}

