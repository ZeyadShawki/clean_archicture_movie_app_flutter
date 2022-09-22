import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app_clean_arch/core/network/app_prefreances.dart';
import 'package:movies_app_clean_arch/core/service_loacater/si.dart';
import 'package:movies_app_clean_arch/movies/presentation/screens/home_bottom_nav_screen.dart';
import 'package:movies_app_clean_arch/movies/presentation/screens/login_screeen.dart';
// ignore: unused_import
import 'package:movies_app_clean_arch/movies/presentation/screens/register_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocater().init();
  AppPrefrenaces().init();
 await  Firebase.initializeApp();
 Widget bootScreen=LoginScreen();

 String uid=await AppPrefrenaces().getUid();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark));



  
 if(uid!='') {
   bootScreen=const HomeBottomNavScreen();
 }

  runApp( MyApp(bootScreen: bootScreen,));
}

class MyApp extends StatelessWidget {
  final Widget bootScreen;
  const MyApp({Key? key, required this.bootScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primarySwatch: Colors.orange,

      ),

      debugShowCheckedModeBanner: false,
      home:  bootScreen,
    );
  }
}


