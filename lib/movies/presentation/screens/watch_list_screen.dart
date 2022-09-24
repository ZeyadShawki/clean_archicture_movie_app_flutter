import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_clean_arch/core/network/api_constants.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/movie_details.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/watch_list_cubit/watch_list_cubit.dart';
import 'package:movies_app_clean_arch/movies/presentation/screens/movie_details_screen.dart';

import '../../../core/service_loacater/si.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>si<WatchListCubit>()..getWatchList(),
      child: BlocConsumer<WatchListCubit,WatchListState>(
        listener: (context,state){
        },
        builder: (context,state) {
          if(state is WatchListSuccess &&context.read<WatchListCubit>().moviesFromApi!=[] ) {
          return  Scaffold(
           backgroundColor: Colors.grey.withOpacity(0.2),
         appBar: AppBar(
           backgroundColor: Colors.transparent,
           leading:InkWell(
               onTap: (){},
               child: const Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,)),
           title: const Text(
             'Favorites',
             style: TextStyle(
               color: Colors.white,
               fontSize: 25,
             ),
           ),
           centerTitle: true,
         ),
           body: SingleChildScrollView(

             physics:  const BouncingScrollPhysics(),
             child: Padding(
               padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 20),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   SizedBox(
                     height: MediaQuery.of(context).size.height*0.8,
                     child: ListView.separated(
                       physics: const BouncingScrollPhysics(),
                         itemBuilder: (context,index)=>InkWell(
                             onTap: (){
                               int id=context.read<WatchListCubit>().movieDetails[index].id;
                               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MovieDetailsScreen(id: id)));
                             },
                             child: movieContainer(context.read<WatchListCubit>().movieDetails[index],context
                             )),
                         separatorBuilder:(context,index)=> const SizedBox(height: 10,),
                         itemCount: context.read<WatchListCubit>().movieDetails.length),
                   )
                 ],
               ),
             ),
           ),

         );
          } else if(state is WatchListLoading) {
            return  Scaffold(
                backgroundColor: Colors.grey.withOpacity(0.2),
                body: const Center(child: CircularProgressIndicator()));
          } else if(context.read<WatchListCubit>().movieDetails==[]){
            return   Scaffold(
              backgroundColor: Colors.grey.withOpacity(0.2),

              body: const Center(child: Text('Watch List Is Empty',style: TextStyle(
                fontSize: 30,
                color: Colors.white
              ),)),
            );
          }else{
           return Scaffold(
              backgroundColor: Colors.grey.withOpacity(0.2),

              body: const Center(child: Text('Watch List Is Empty',style: TextStyle(
                  fontSize: 30,
                  color: Colors.white
              ),)),
            );
          }

        }
      ),
    );
  }

  Widget movieContainer(MovieDetails movie,context){
    return Container(
      height: 150,
      width: double.infinity,
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(30),
         color: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade900,       ),
      child:  Padding(

        padding: const EdgeInsets.all(15.0),
        child:   Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
             ClipRRect(
               borderRadius: BorderRadius.circular(20),
               child: Image(

                  height: 140,
                  image: NetworkImage(
                ApiConstants().networkimagemaker(movie.posterPath)
            )),
             ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20),
                      child: Text(
                      movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
            ),
                    ),


                       Expanded(
                         child: Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 20),
                         child:   Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Text(movie.releaseDate.split('-').first,
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                        const SizedBox(width: 10,),
                          const Icon(Icons.star,color: Colors.yellow,size: 20,),
                            Text(
                              movie.voteAverage.roundToDouble().toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: (){
                                WatchListCubit.get(context).removeFromWatchList( movie.id);
                              },
                              child: Row(children: const [
                                Icon(Icons.remove_circle_outlined,color: Colors.redAccent,),
                                Text('Remove',style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.red
                                ),)
                              ],),
                            ),
                    ],),
                     ),
                       )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

}
