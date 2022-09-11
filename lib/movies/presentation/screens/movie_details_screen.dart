import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_clean_arch/core/network/api_constants.dart';
import 'package:movies_app_clean_arch/core/service_loacater/si.dart';
import 'package:movies_app_clean_arch/core/utils/enum_movie_state.dart';
import 'package:movies_app_clean_arch/movies/domain/entities/movie_details.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/movie_details_cubit.dart';

class MovieDetailsScreen extends StatelessWidget {
  int id;
   MovieDetailsScreen({Key? key,required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (context)=>si<MovieDetailsCubit>()..getMovieDetails(id)..getRecomended(id),

      child: BlocConsumer<MovieDetailsCubit,MovieDetailsInitial>(

        listener: (context,state){},
        builder: (context,state){
          print(id);
          if(state.recommendedstate==RequestState.isLoaded) {
            return Scaffold(
            backgroundColor: Colors.grey.withOpacity(0.3),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                      width: double.infinity,
                      image: NetworkImage
                        (ApiConstants().networkimagemaker(state.movieDetails.backDropPath))),
                   Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: Text(state.movieDetails.title,
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 20,
                         fontWeight: FontWeight.bold

                       ),
                     ),
                   ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                           decoration: BoxDecoration(
                             color: Colors.grey.withOpacity(0.5),
                             borderRadius: BorderRadius.circular(5)
                           ),
                          child: Text(state.movieDetails.releaseDate.split('-').first,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                               fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Row(
                          children: [
                            Icon(Icons.star,color: Colors.yellow,size: 20,),
                            SizedBox(width: 5,),
                            Text(state.movieDetails.voteAverage.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                            ),

                          ],
                        ),
                        SizedBox(width: 20,),
                        Text('${(state.movieDetails.runtime/60).floor()}h ${state.movieDetails.runtime-60>120?(state.movieDetails.runtime)-120:(state.movieDetails.runtime)-60}m',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                    child: Text(state.movieDetails.overview,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        fontSize: 14
                      ),),
                  ),
                  SizedBox(
                   height: 30,
                   child: ListView.separated(
                     padding: EdgeInsets.symmetric(horizontal: 15),
                     scrollDirection: Axis.horizontal,
                     itemBuilder: (context,index){
                     return Container(
                       color: Colors.grey.withOpacity(0.1),
                       padding: EdgeInsets.symmetric(horizontal: 10),
                       child: Center(
                         child: Text(
                             state.movieDetails.genre[index].name,
                           style: TextStyle(
                             color: Colors.grey,
                           ),

                         ),
                       ),
                     );
                   },
                   itemCount: state.movieDetails.genre.length,
                     separatorBuilder: (context,state)=>SizedBox(width: 10,),
                   ),
                 ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15,top: 20,bottom: 10),
                    child: Text('More Like This',
                    style:  TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                      fontSize: 15
                      ),

                    ),
                  ),

                   state.recommendedstate==RequestState.isLoaded?
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.5,

                    child: GridView.builder(
                      padding: EdgeInsets.all(15),
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: 150,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5
                        ),
                      itemBuilder: (context,int index) {
                        int currentindex=index;

                        return  InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MovieDetailsScreen(id: state.recommendedmovieDetails[index].id)));
                          },
                          child: imageGridView(
                              state.recommendedmovieDetails[currentindex].posterPath),
                        );
                      },
                    itemCount: state.recommendedmovieDetails.length,
                    ),

                  ):
                      SizedBox(height:500, child: Center(child: CircularProgressIndicator()))


                ],
              ),
            )
          );
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget imageGridView(String? Imagepath){
    return Image(
        fit: BoxFit.fill,
        image: NetworkImage(
        ApiConstants().networkimagemaker(Imagepath)
    ));
  }
}
