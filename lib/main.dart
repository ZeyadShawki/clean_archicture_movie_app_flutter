import 'package:flutter/material.dart';
import 'package:movies_app_clean_arch/core/service_loacater/si.dart';
import 'package:movies_app_clean_arch/movies/presentation/screens/movie_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocater().init();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeMovieScreen(),
    );
  }
}


