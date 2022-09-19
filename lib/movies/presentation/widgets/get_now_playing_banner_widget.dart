
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_clean_arch/core/network/api_constants.dart';
import 'package:movies_app_clean_arch/core/utils/enum_movie_state.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/movie_bloc/bloc_state.dart';
import 'package:movies_app_clean_arch/movies/presentation/screens/movie_details_screen.dart';

import '../controller/movie_bloc/bloc.dart';


class BannerWidget extends StatelessWidget {
  const BannerWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieBloc,MovieState>(
      buildWhen: (previous,current)=>previous.nowPlayingState!=current.nowPlayingState,
      listener: (context,state){

      },
      builder: (context,state){

        if(state.nowPlayingState == RequestState.isLoaded) {
          return RefreshIndicator(
            onRefresh: ()async{
              context.read<MovieBloc>().getNowPlaying();


            },
            child: CarouselSlider.builder(

              itemBuilder: (BuildContext context, int index, int realIndex) {
                return InkWell(
                  child: Stack(
                    children: [
                      ShaderMask(
                        shaderCallback: (bound){
                          return  LinearGradient(
                              end: Alignment.topCenter,
                              begin: FractionalOffset.bottomCenter,
                              colors: [
                                Colors.grey.shade900,
                                Colors.grey.shade900,
                                Colors.transparent,
                              ],

                              stops: const [
                                0.0,
                                0.1,
                                0.45,
                              ])
                              .createShader(bound);   },
                        blendMode: BlendMode.srcOver,
                        child: Image(
                          height: MediaQuery.of(context).size.height*0.4,
                          width: double.infinity,
                          image:  NetworkImage(
                              ApiConstants().networkimagemaker(state.nowPlayingMovie[index].backdropPath),
                          ),
                          fit: BoxFit.fill,

                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.4,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: const [
                                Icon(Icons.circle,color: Colors.red,size: 20,),

                                Text('Now Playing',style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                ),),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Text(state.nowPlayingMovie[index].title.toString(),style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 25
                            ),)

                          ],
                        ),
                      ),
                    ],
                  ),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                      MovieDetailsScreen(id: state.nowPlayingMovie[index].id as int)
                    ));
                  },
                );
              },
              options: CarouselOptions(
                viewportFraction: 1,
                scrollDirection: Axis.horizontal,
                height: MediaQuery.of(context).size.height*0.4,
                autoPlay: true,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
              ),
              itemCount: state.nowPlayingMovie.length,

            ),
          );
        }
        else if(state.nowPlayingState==RequestState.isLoading) {
          return SizedBox(
              height: MediaQuery.of(context).size.height*0.4,
              child: const Center(child: CircularProgressIndicator()));
        }else {
          return  Text(state.nowPlayingMessage);
        }
       }
      );
  }
}
