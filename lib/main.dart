import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app_clean_arch/core/network/app_prefreances.dart';
import 'package:movies_app_clean_arch/core/service_loacater/si.dart';
import 'package:movies_app_clean_arch/movies/presentation/screens/login_screeen.dart';
import 'package:movies_app_clean_arch/movies/presentation/screens/movie_screen.dart';
// ignore: unused_import
import 'package:movies_app_clean_arch/movies/presentation/screens/register_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocater().init();
  AppPrefrenaces().init();
 await  Firebase.initializeApp();
 Widget bootScreen=LoginScreen();
 String uid=await AppPrefrenaces().getUid();

 if(uid!='') {
   bootScreen=const HomeMovieScreen();
 }

  runApp( MyApp(bootScreen: bootScreen,));
}

class MyApp extends StatelessWidget {
  final Widget bootScreen;
  const MyApp({Key? key, required this.bootScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      debugShowCheckedModeBanner: false,
      home:  bootScreen,
    );
  }
}


