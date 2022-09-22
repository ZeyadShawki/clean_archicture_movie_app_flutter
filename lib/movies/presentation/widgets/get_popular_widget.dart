import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_clean_arch/core/network/api_constants.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/movie_bloc/bloc_state.dart';

import '../controller/movie_bloc/bloc.dart';
import '../screens/movie_details_screen.dart';


class GetPopularListViewWidget extends StatelessWidget {
  const GetPopularListViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    BlocConsumer<MovieBloc,MovieState>(
      buildWhen: (previous,current)=>previous.popularState!=current.popularState,

      listener: (context,state){},
      builder: (context,state){

        if(state.popularMovie!=[]) {
           return  Container(

             height: MediaQuery.of(context).size.height*0.3,

              padding: const EdgeInsets.symmetric(horizontal: 10),
             child: ListView.separated(
               padding: const EdgeInsets.symmetric(horizontal: 10),
               scrollDirection: Axis.horizontal,
               physics: const BouncingScrollPhysics(),
               itemBuilder: (context,index){
                 return InkWell(
                   onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                         MovieDetailsScreen(id: state.popularMovie[index].id as int)
                     ));
                   },
                   child: ClipRRect(
                     borderRadius: BorderRadius.circular(15),
                     child: Image(
                       width: 150,
                      height: 300,
                       fit: BoxFit.fill,
                       image: NetworkImage(
                         ApiConstants().networkimagemaker(state.popularMovie[index].posterPath),
                       ),
                     ),
                   ),
                 );
               },
               itemCount: state.popularMovie.length,
               separatorBuilder:  (context,index){
                 return const SizedBox(width: 10,);
               },
             ),
           );

         }
         else {
           return SizedBox(
             height: MediaQuery.of(context).size.height*0.2,
             child: const Center(child: CircularProgressIndicator(),),);
         }
       },
    );
  }
}
