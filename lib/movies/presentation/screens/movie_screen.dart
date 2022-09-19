import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/movie_bloc/bloc_state.dart';
import 'package:movies_app_clean_arch/movies/presentation/screens/search_screen.dart';
import 'package:movies_app_clean_arch/movies/presentation/widgets/get_now_playing_banner_widget.dart';
import 'package:movies_app_clean_arch/movies/presentation/widgets/get_popular_widget.dart';
import 'package:movies_app_clean_arch/movies/presentation/widgets/get_top_rated_widget.dart';

import '../../../core/service_loacater/si.dart';
import '../controller/movie_bloc/bloc.dart';


class HomeMovieScreen extends StatelessWidget {
  const HomeMovieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return  BlocProvider<MovieBloc>(
    create: (context){
      return si<MovieBloc>()..getNowPlaying()..getPopular()..getTopRated()..getuserinfo();
    },
    child: BlocConsumer<MovieBloc,MovieState>(
      builder: (context,state){
        return Scaffold(
          backgroundColor: Colors.grey.withOpacity(0.2),
          drawer: Drawer(
            width: 250,
            backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.grey.shade900.withOpacity(0.99),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50,),
                      CircleAvatar(
                        backgroundImage: NetworkImage(state.user.profileImage),
                        radius: 60,
                      ),
                      const SizedBox(height: 10,),
                      Text(
                       state.user.userName,
                        style: const TextStyle(
                          color: Colors.white,
                            fontSize: 25
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        state.user.email,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15
                        ),
                      ),
                      const SizedBox(height: 20,),

                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.home_outlined,color: Colors.grey,),
                          SizedBox(width: 20,),
                          Text('Home',style: TextStyle(
                            fontSize: 18
                          ),)
                        ],
                      ),
                      const SizedBox(height: 30,),
                      Row(
                        children: const [
                          Icon(Icons.favorite_border,color: Colors.grey,),
                          SizedBox(width: 20,),
                          Text('Favorites',style: TextStyle(
                              fontSize: 18
                          ),)
                        ],
                      ),
                      const SizedBox(height: 30,),

                      Row(
                        children: const [
                          Icon(Icons.settings,color: Colors.grey,),
                          SizedBox(width: 20,),
                          Text('settings',style: TextStyle(
                              fontSize: 18
                          ),)
                        ],
                      ),
                      const SizedBox(height: 30,),

                    

                      const Divider(thickness: 2,),
                      const SizedBox(height: 30,),

                      Row(
                        children: const [
                          Icon(Icons.notifications_outlined,color: Colors.grey,),
                          SizedBox(width: 20,),
                          Text('Notifications',style: TextStyle(
                              fontSize: 18
                          ),)
                        ],
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
          ),
          appBar: AppBar(

            centerTitle: true,
            elevation: 0,
            title: const Text(
              'Movie',
            ),
            actions: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const SearchScreen()));
              },
                  icon: const Icon(
                      Icons.search_outlined
                  ))
            ],
            backgroundColor: Colors.transparent,
          ),
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
                      InkWell(
                        onTap: ()=>context.read<MovieBloc>().getNowPlaying(),
                        child: const Text('Popular',style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),),
                      ),
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
        );
      },
      listener:  (context,state){
      },
    ),
  );
  }
}
