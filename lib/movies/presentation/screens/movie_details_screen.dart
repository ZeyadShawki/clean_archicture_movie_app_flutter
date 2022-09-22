import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies_app_clean_arch/core/network/api_constants.dart';
import 'package:movies_app_clean_arch/core/service_loacater/si.dart';
import 'package:movies_app_clean_arch/core/utils/enum_movie_state.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/movie_details_cubit/movie_details_cubit.dart';

import '../controller/movie_details_cubit/movie_details_state.dart';

// ignore: must_be_immutable
class MovieDetailsScreen extends StatelessWidget {
  int id;
   MovieDetailsScreen({Key? key,required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(

      create: (context)=>si<MovieDetailsCubit>()..getMovieDetails(id)..getRecomended(id),

      child: BlocConsumer<MovieDetailsCubit,MovieDetailsInitial>(

        listener: (context,state){
        },
        builder: (context,state){
          if(state.recommendedstate==RequestState.isLoaded) {
            return Scaffold(

            backgroundColor: Colors.grey.shade900,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child:  Stack(
                children: [
                   Stack(
                    children: [
                      Image(

                          width: double.infinity,
                          image: NetworkImage
                            (ApiConstants().networkimagemaker(state.movieDetails.backDropPath))),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
                        child: IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                      ),

                    ],
                       ),
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 190),

                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))

                          ),
                          color: Colors.grey.shade900,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 30,),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 150,vertical: 10),
                                child: Divider(thickness: 3,color: Colors.grey,),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(state.movieDetails.title,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold

                                    ),
                                    textAlign: TextAlign.center,

                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Text(state.movieDetails.releaseDate.split('-').first,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.star,color: Colors.yellow,size: 20,),
                                        const SizedBox(width: 5,),
                                        Text(state.movieDetails.voteAverage.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),

                                      ],
                                    ),
                                    const SizedBox(width: 20,),
                                    Text('${(state.movieDetails.runtime/60).floor()}h ${state.movieDetails.runtime-60>120?(state.movieDetails.runtime)-120:(state.movieDetails.runtime)-60}m',
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold
                                      ),)
                                  ],
                                ),
                              ),
                               const SizedBox(height: 10,),
                               Center(
                                 child: InkWell(
                                   onTap: (){
                                     List<int> index=[];
                                     index.add(state.movieDetails.id);
                                     context.read<MovieDetailsCubit>().setWatchList(index);
                                     if(state.addtoListMessage!='') {
                                       Fluttertoast.showToast(
                                           msg: state.addtoListMessage,
                                         gravity: ToastGravity.BOTTOM
                                       );
                                     }
                                   },
                                   child: Container(
                                     padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.deepOrange,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child:  const Text(
                                      'Add to WatchList',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                              ),
                                 ),
                               ),
                              const SizedBox(height: 10,),

                              const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text('Storyline',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold

                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                                child: Text(state.movieDetails.overview,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15
                                  ),),
                              ),
                              SizedBox(
                                height: 30,
                                child: ListView.separated(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context,index){
                                    return Container(
                                      color: Colors.grey.withOpacity(0.1),
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Center(
                                        child: Text(
                                          state.movieDetails.genre[index].name,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),

                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: state.movieDetails.genre.length,
                                  separatorBuilder: (context,state)=>const SizedBox(width: 10,),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 15.0,right: 15,top: 20,bottom: 10),
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
                                  padding: const EdgeInsets.all(15),
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                              const SizedBox(height:500, child: Center(child: CircularProgressIndicator()))


                            ],
                          ),
                        ),
                      ),
                      Container(

                        margin: const EdgeInsets.only(top: 100,left: 20),
                        child:  ClipRRect(
                          borderRadius: BorderRadius.circular(20),

                           child: Image(
                             fit: BoxFit.fill,
                              height: 160,
                              width: 100,

                              image: NetworkImage(ApiConstants().networkimagemaker(state.movieDetails.posterPath))),
                        ),
                      ),
                    ],
                  )

                ],
              ),

            )
          );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget imageGridView(String? Imagepath){
    return Image(
        fit: BoxFit.fill,
        image: NetworkImage(
        ApiConstants().networkimagemaker(Imagepath)
    ));
  }
}
