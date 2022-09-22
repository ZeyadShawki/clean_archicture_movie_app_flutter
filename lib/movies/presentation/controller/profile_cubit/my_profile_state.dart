part of 'my_profile_cubit.dart';

@immutable
abstract class MyProfileState {}

class MyProfileInitial extends MyProfileState {}
class MyProfileSuccess extends MyProfileState {
  final UserSignIn user;

  MyProfileSuccess(this.user);

}
class MyProfileError extends MyProfileState {
  final String message;

  MyProfileError(this.message);

}
