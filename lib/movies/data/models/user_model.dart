import 'package:movies_app_clean_arch/movies/domain/entities/user.dart';

class UserModel extends UserSignIn{
  const UserModel({
    required super.userName,
    required super.email,
    required super.password,
    required super.phone,
    required super.profileImage,
  });

  factory UserModel.fromJson(Map<String,dynamic>? json)=>UserModel
    (
      userName: json!['username']??'',
      email: json['email']??'',
      password: json['password']??"",
      phone: json['phone']??'',
      profileImage: json['profile_image']??"",
  );
  Map<String,dynamic> toJson()=>{
    'username':userName,
    'email':email,
    'password':password,
    'phone':phone,
    'profile_image':profileImage,
  };




}