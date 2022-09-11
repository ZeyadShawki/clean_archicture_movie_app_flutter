import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/bloc.dart';
import 'package:movies_app_clean_arch/movies/presentation/widgets/get_now_playing_banner_widget.dart';
import 'package:movies_app_clean_arch/movies/presentation/widgets/get_popular_widget.dart';
import 'package:movies_app_clean_arch/movies/presentation/widgets/get_top_rated_widget.dart';

import '../../../core/service_loacater/si.dart';


class HomeMovieScreen extends StatelessWidget {
  const HomeMovieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return  BlocProvider<MovieBloc>(
    create: (context){
      return si<MovieBloc>()..getNowPlaying()..getPopular()..getTopRated();
    },
    child: Scaffold(
      backgroundColor: Colors.grey.shade900,
      body:
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            //banner
            const BannerWidget(),
            // popular see more
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  const Text('Popular',style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),),
                  Row(
                    children: const [
                      Text('See More',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                      Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,)
                    ],
                  )
                ],
              ),
            ),
          // popluer  list view
      const  GetPopularListViewWidget(),
            // toprated see more

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  const Text('Top Rated',style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),),
                  Row(
                    children: const [
                      Text('See More',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                      Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,)
                    ],
                  )
                ],
              ),
            ),
            // toprated  list view

          const GetTopRatedListViewWidget(),


          ],
        ),
      ),
    ),
  );
  }
}
